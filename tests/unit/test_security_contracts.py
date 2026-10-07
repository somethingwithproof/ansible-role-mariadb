"""Offline security contracts; no database or GitHub connection is used."""

import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

import yaml

ROOT = Path(__file__).resolve().parents[2]
MOCK_MYSQL = """#!/usr/bin/env python3
import os
import sys
query = sys.argv[-1]
case = os.environ.get('MOCK_CASE', 'success')
if query == 'SELECT 1;':
    sys.exit(1 if case == 'connection_failure' else 0)
if 'SHOW MASTER STATUS' in query:
    print('File: mysql-bin.000001\\nPosition: 128')
elif 'SHOW SLAVE STATUS' in query:
    print('Slave_IO_Running: ' + ('No' if case == 'inactive' else 'Yes'))
    print('Slave_SQL_Running: Yes')
elif 'SELECT COUNT(*)' in query:
    print('COUNT(*)\\n' + ('0' if case == 'missing_data' else '1'))
"""
MOCK_GH = """#!/usr/bin/env python3
import json
import os
import sys
from pathlib import Path
args = sys.argv[1:]
case = os.environ.get('MOCK_CASE', 'SUCCESS')
if args[:2] == ['pr', 'list']:
    print('17 ' + 'a' * 40)
elif args[:2] == ['pr', 'checks']:
    if case != 'empty':
        print(case)
elif args[:2] == ['pr', 'merge']:
    Path(os.environ['MOCK_MERGE_LOG']).write_text(json.dumps(args))
else:
    sys.exit(2)
"""


class SecurityContracts(unittest.TestCase):
    """Protect credentials and preserve fail-closed test/merge behavior."""

    def run_with_mocks(self, command, programs, case):
        """Execute real repository code with isolated command substitutes."""
        with tempfile.TemporaryDirectory() as directory:
            folder = Path(directory)
            for name, source in programs.items():
                target = folder / name
                target.write_text(source)
                target.chmod(0o700)
            log = folder / "merge.json"
            environment = {
                **os.environ,
                "PATH": str(folder) + os.pathsep + os.environ["PATH"],
                "MOCK_CASE": case,
                "MOCK_MERGE_LOG": str(log),
                "GITHUB_REPOSITORY": "offline/fixture",
            }
            result = subprocess.run(
                command,
                env=environment,
                capture_output=True,
                text=True,
                timeout=10,
                check=False,
            )
            return result, json.loads(log.read_text()) if log.exists() else []

    def test_replication_results(self):
        """Only successful connections, status and data may produce success."""
        command = ["bash", str(ROOT / "tests/helpers/test_replication.sh")]
        for case in [
            "success",
            "connection_failure",
            "inactive",
            "missing_data",
        ]:
            with self.subTest(case=case):
                result, _ = self.run_with_mocks(
                    command,
                    {"mysql": MOCK_MYSQL, "sleep": "#!/bin/sh\nexit 0\n"},
                    case,
                )
                self.assertEqual(
                    result.returncode, 0 if case == "success" else 1
                )
                self.assertEqual(
                    "All replication tests passed!" in result.stdout,
                    case == "success",
                )

    def test_merge_requires_checks_and_exact_commit(self):
        """Exercise the actual workflow body, with no token or network."""
        workflow = yaml.safe_load(
            (ROOT / ".github/workflows/dependabot-auto-merge.yml").read_text()
        )
        body = workflow["jobs"]["merge"]["steps"][0]["run"]
        for case in [
            "SUCCESS",
            "PENDING",
            "FAILURE",
            "ERROR",
            "CANCELLED",
            "empty",
        ]:
            with self.subTest(case=case):
                result, merge = self.run_with_mocks(
                    ["bash", "-c", body], {"gh": MOCK_GH}, case
                )
                self.assertEqual(result.returncode, 0, result.stderr)
                if case == "SUCCESS":
                    self.assertIn("--match-head-commit", merge)
                    index = merge.index("--match-head-commit")
                    self.assertEqual(merge[index + 1], "a" * 40)
                else:
                    self.assertFalse(merge)

    def test_credential_templates_are_private(self):
        """Credential-bearing scripts must be root-only and redact diffs."""
        for file, source in [
            ("backup.yml", "mariadb_backup.sh.j2"),
            ("monitoring.yml", "mariadb_monitoring.sh.j2"),
        ]:
            tasks = yaml.safe_load((ROOT / "tasks" / file).read_text())
            task = next(
                task
                for task in tasks
                if task.get("ansible.builtin.template", {}).get("src") == source
            )
            template = task["ansible.builtin.template"]
            self.assertEqual(int(template["mode"], 8) & 0o077, 0)
            self.assertEqual(template["owner"], "root")
            self.assertTrue(task["no_log"])


if __name__ == "__main__":
    unittest.main()
