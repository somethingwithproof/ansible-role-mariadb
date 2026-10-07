<!--
SPDX-FileCopyrightText: 2026 Thomas Vincent
SPDX-License-Identifier: MIT
-->

# MariaDB Ansible role agent instructions

## Project and layout

This is an Ansible role, not a Python application or an Ansible collection.
`tasks/main.yml` orchestrates installation, validation, configuration, security,
users/databases, replication, backups and monitoring. Public defaults belong
in `defaults/main.yml`; configuration and scripts belong in `templates/`;
service actions belong in `handlers/`. Preserve the `mariadb_` variable namespace.

`molecule/` has default, multi-instance, backup, monitoring and version-matrix
scenarios. `tests/` contains playbooks and replication helpers; `dev/` holds
Docker development fixtures. `.ansible/` is generated tooling state, not role
source or a portable role installation.

## Checks and tool compatibility

Read `CONTRIBUTING.md`, `Makefile`, `.pre-commit-config.yaml`, `requirements.txt`
and `.github/workflows/ci.yml`. Requirements, old README support claims and the
integration matrix differ; report discrepancies rather than claiming parity.
The lint hook uses Python 3.12, ansible-lint 26.9.0 and ansible-core 2.21.4.

```sh
mise exec python@3.12 -- pre-commit run --all-files
mise exec python@3.12 -- make lint
```

Install hook environments normally; do not bypass hooks or allow incompatible
Ansible internals to be imported. For an explicitly selected disposable Docker
test environment:

```sh
mise exec python@3.12 -- molecule test -s default
mise exec python@3.12 -- molecule test -s multi-instance
mise exec python@3.12 -- molecule test -s backup
```

Use named scenarios directly; some older Makefile convenience paths differ from
Molecule's scenario selection. Passing lint is not replication/restore evidence.

## Database safety and review

Preserve idempotence, handler-driven restarts, input validation, secret redaction,
file permissions, replication identity and backup retention. Verify restore and
replication behavior in disposable fixtures when modifying those paths. Never
reset live root credentials, purge databases, delete backups or change a real
replication topology for validation. Keep fixture passwords confined to tests.
Do not claim MariaDB/Ansible version support without matching runtime evidence.

## Working rules

Select required language runtimes through `mise`. Read the checked-out manifests,
lockfiles and GitHub Actions before choosing versions or commands; do not infer
support from an old README example. Keep changes focused and preserve public
interfaces, licenses and existing correctness/security checks.

Keep credentials, customer data, `.omc/`, `.worktrees/` and generated output out
of commits. Never disable checks or suppress findings just to obtain a passing
result. Report the commands run, results and untested environments. Publishing,
deploying, modifying live systems and merging require task authorization.
