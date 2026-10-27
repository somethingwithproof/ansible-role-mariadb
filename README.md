# MariaDB Ansible Role

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](./LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

An Ansible role for installing MariaDB, provisioning databases and users, and configuring optional backup and monitoring tasks. The role separates installation, configuration, validation, and operational tasks so each can be reviewed independently.

## Capabilities

| Area | Implementation |
| --- | --- |
| Installation and configuration | [install.yml](tasks/install.yml), [configure.yml](tasks/configure.yml), and configuration templates |
| Input validation and account setup | [validate.yml](tasks/validate.yml), [secure.yml](tasks/secure.yml), [users.yml](tasks/users.yml) |
| Database provisioning | [databases.yml](tasks/databases.yml) |
| Replication settings | [replication.yml](tasks/replication.yml) sets server IDs and primary-side binary logging/user settings |
| Scheduled backups | [backup.yml](tasks/backup.yml) and the [backup script template](templates/mariadb_backup.sh.j2) |
| Monitoring | [monitoring.yml](tasks/monitoring.yml) and exporter/check templates |

The checked-in replication tasks do not implement automated failover or complete replica initialization. Multiple Molecule instances are a test topology, not evidence of multi-instance deployment on one host. Review backup encryption, restore behavior, and database-version compatibility for your deployment; they are not guaranteed by this README.

## Install and use

```bash
ansible-galaxy role install git+https://github.com/somethingwithproof/ansible-role-mariadb.git
ansible-galaxy collection install community.mysql
```

```yaml
- hosts: database_servers
  become: true
  vars:
    mariadb_root_password: "{{ vault_mariadb_root_password }}"
    mariadb_databases:
      - name: app_db
        encoding: utf8mb4
        collation: utf8mb4_unicode_ci
    mariadb_users:
      - name: app_user
        password: "{{ vault_app_db_password }}"
        host: "192.168.0.%"
        priv: "app_db.*:ALL"
  roles:
    - ansible-role-mariadb
```

Provide the referenced password variables through Ansible Vault or your secret-management system. Use [defaults/main.yml](defaults/main.yml) for the actual option names and defaults.

## Requirements and compatibility

The current controller is Ansible 14.5.0 / ansible-core 2.21.5 with Python
3.13. The `lts` scenario exercises native distribution packages on Ubuntu
22.04, 24.04 and 26.04, Debian 12 and 13, and Rocky Linux 9 and 10. EL aliases
in metadata do not establish separate RHEL or AlmaLinux certification.

Ubuntu 26.04, Debian 13 and EL10 default to native packages. Set
`mariadb_configure_repo: false` to use native packages on older maintained
releases too. Existing older-release repository selection stays compatible;
review and explicitly select a vendor-supported repository release before
opting into the external repository path. The legacy `mariadb_version` value
selects that external repository, not the native server version.

The role discovers the running server's version and data directory before
writing configuration. This preserves Ubuntu 26.04's `/var/lib/mariadb` and
existing database storage. An explicit conflicting `mariadb_data_dir` fails
with a migration requirement; the role does not move data. Public package,
service, socket and configuration-file overrides remain available.

Password changes use parameterized statements so MariaDB can enforce its
strict password-validation plugin. Root's private client file uses the local
Unix socket. Unchanged accounts retain their grants and passwords.

## Development and testing

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

These targets are defined in the [Makefile](Makefile). Molecule requires its driver and test dependencies. Docker targets use files under [dev](dev); `make docker-test` is the basic Docker target, not `make test-docker`.

## Documentation, security, and license

- [Configuration examples](docs/README.md)
- [Contributing](CONTRIBUTING.md)
- [Security policy](SECURITY.md)
- [MIT license](LICENSE)
