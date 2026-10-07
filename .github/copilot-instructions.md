<!--
SPDX-FileCopyrightText: 2026 Thomas Vincent
SPDX-License-Identifier: MIT
-->

# ansible-role-mariadb implementation and review instructions

Read [AGENTS.md](../AGENTS.md) for the complete repository-specific guidance.

## Review priorities

Review idempotence, credentials/permissions, service restarts, replication identity, backup and restore safety.

Require focused regression evidence for changed behavior and preserve existing
correctness/security checks. `mise exec python@3.12 -- pre-commit run --all-files`; named Molecule scenarios require disposable Docker fixtures.

Flag unsupported maturity claims, hidden failures, credentials in code/logs, and
generated output presented as first-party implementation. Review permissions,
immutable Action pins and fork-secret isolation when workflows change. A skipped
check or absent check result is not proof that validation ran.

Keep changes within the requested scope and use `mise` for language runtimes.
