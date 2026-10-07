# MariaDB Ansible Role

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![License](https://img.shields.io/badge/license-MIT-blue)](./LICENSE)

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

[Role metadata](meta/main.yml) declares Ansible 9.0.0 as its minimum and lists Ubuntu, Debian, and EL platform targets. [Requirements](requirements.txt), [development requirements](requirements-dev.txt), and [CI](.github/workflows/ci.yml) define the tool versions and configured test matrix. Declared targets and test scenarios do not establish a passing compatibility matrix for every OS or MariaDB release.

## Development and testing

```bash
make lint
make molecule-test
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
