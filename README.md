<!-- translations:start -->
**Languages:** **English** · [Deutsch](docs/i18n/de/README.md) · [Español](docs/i18n/es/README.md) · [Français](docs/i18n/fr/README.md) · [Português (BR)](docs/i18n/pt-BR/README.md) · [Русский](docs/i18n/ru/README.md) · [日本語](docs/i18n/ja/README.md) · [한국어](docs/i18n/ko/README.md) · [简体中文](docs/i18n/zh-CN/README.md) · [العربية](docs/i18n/ar/README.md) · [हिन्दी](docs/i18n/hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** **English** · [Deutsch](docs/i18n/de/README.md) · [Español](docs/i18n/es/README.md) · [Français](docs/i18n/fr/README.md) · [Italiano](docs/i18n/it/README.md) · [Português (BR)](docs/i18n/pt-BR/README.md) · [Nederlands](docs/i18n/nl/README.md) · [Русский](docs/i18n/ru/README.md) · [Українська](docs/i18n/uk/README.md) · [日本語](docs/i18n/ja/README.md) · [한국어](docs/i18n/ko/README.md) · [简体中文](docs/i18n/zh-CN/README.md) · [繁體中文](docs/i18n/zh-TW/README.md) · [العربية](docs/i18n/ar/README.md) · [हिन्दी](docs/i18n/hi/README.md) · [Polski](docs/i18n/pl/README.md) · [Türkçe](docs/i18n/tr/README.md) · [Svenska](docs/i18n/sv/README.md) · [Tiếng Việt](docs/i18n/vi/README.md) · [Bahasa Indonesia](docs/i18n/id/README.md)
- **Africa:** [Afrikaans](docs/i18n/af-ZA/README.md) · [አማርኛ](docs/i18n/am-ET/README.md) · [العربية (مصر)](docs/i18n/ar-EG/README.md) · [العربية (المغرب)](docs/i18n/ar-MA/README.md) · [Français (Maroc)](docs/i18n/fr-MA/README.md) · [Français (Sénégal)](docs/i18n/fr-SN/README.md) · [Hausa](docs/i18n/ha-NG/README.md) · [Igbo](docs/i18n/ig-NG/README.md) · [Malagasy](docs/i18n/mg-MG/README.md) · [Kinyarwanda](docs/i18n/rw-RW/README.md) · [Soomaali](docs/i18n/so-SO/README.md) · [Kiswahili](docs/i18n/sw-KE/README.md) · [isiXhosa](docs/i18n/xh-ZA/README.md) · [Yorùbá](docs/i18n/yo-NG/README.md) · [isiZulu](docs/i18n/zu-ZA/README.md)
- **Asia:** [বাংলা](docs/i18n/bn/README.md) · [فارسی](docs/i18n/fa/README.md) · [עברית](docs/i18n/he/README.md) · [मराठी](docs/i18n/mr/README.md) · [தமிழ்](docs/i18n/ta/README.md) · [తెలుగు](docs/i18n/te/README.md) · [ไทย](docs/i18n/th/README.md) · [اردو](docs/i18n/ur/README.md) · [Bahasa Melayu](docs/i18n/ms/README.md) · [Filipino](docs/i18n/fil/README.md)

</details>
<!-- translations:end -->

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
    mariadb_configure_repo: false
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

Native distribution packages are the default on every tested platform.
Existing external repository files are not removed, and the role does not
migrate an installed server between package sources or major versions. Review
package-manager conflicts before migrating an existing external installation.

The external repository path is an explicit, untested opt-in through
`mariadb_configure_repo: true`. Its legacy `mariadb_version` selector is not a
native-server version or a recommendation for a supported upstream release.
The old hard-coded mirrors do not cover every current distribution; use the
native default or independently qualify the repository configuration first.

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
