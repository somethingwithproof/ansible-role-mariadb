<!--
SPDX-FileCopyrightText: 2026 Thomas Vincent
SPDX-License-Identifier: MIT
-->

# ansible-role-mariadb coding guide

Read [AGENTS.md](AGENTS.md) before making changes. It contains the repository's
architecture, canonical commands, supported boundaries and operating rules.
Follow any applicable nested instructions and the checked-out CI configuration.

## Project priorities

Review idempotence, credentials/permissions, service restarts, replication identity, backup and restore safety.

## Verification

`mise exec python@3.12 -- pre-commit run --all-files`; named Molecule scenarios require disposable Docker fixtures.

Separate offline checks from operations that change hosts, databases, firewalls
or published artifacts. State verification limits and preserve existing controls.
Select language runtimes through `mise`; never commit local session state or secrets.
