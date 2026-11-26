<!-- translations:start -->
**Languages:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · **简体中文** · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · **简体中文** · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# MariaDB Ansible 角色

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

一个用于安装 MariaDB、预配数据库和用户，以及配置可选备份和监控任务的 Ansible 角色。该角色将安装、配置、验证和运维任务分开，以便各自独立审查。

## 功能

| 领域 | 实现 |
| --- | --- |
| 安装与配置 | [install.yml](../../../tasks/install.yml)、[configure.yml](../../../tasks/configure.yml) 及配置模板 |
| 输入验证与账户设置 | [validate.yml](../../../tasks/validate.yml)、[secure.yml](../../../tasks/secure.yml)、[users.yml](../../../tasks/users.yml) |
| 数据库预配 | [databases.yml](../../../tasks/databases.yml) |
| 复制设置 | [replication.yml](../../../tasks/replication.yml) 设置服务器 ID 和主库侧的二进制日志/用户设置 |
| 定时备份 | [backup.yml](../../../tasks/backup.yml) 和[备份脚本模板](../../../templates/mariadb_backup.sh.j2) |
| 监控 | [monitoring.yml](../../../tasks/monitoring.yml) 以及导出器/检查模板 |

已检入的复制任务未实现自动故障转移或完整的副本初始化。多个 Molecule 实例仅作为测试拓扑，不代表单主机多实例部署的依据。请针对你的部署审查备份加密、恢复行为以及数据库版本兼容性；本 README 对此不作保证。

## 安装与使用

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

通过 Ansible Vault 或你的密钥管理系统提供所引用的密码变量。请参阅 [defaults/main.yml](../../../defaults/main.yml) 了解实际的选项名称和默认值。

## 要求与兼容性

当前控制节点为 Ansible 14.5.0 / ansible-core 2.21.5 及 Python 3.13。`lts` 场景在 Ubuntu 22.04、24.04 和 26.04、Debian 12 和 13 以及 Rocky Linux 9 和 10 上测试发行版原生软件包。元数据中的 EL 别名并不构成单独的 RHEL 或 AlmaLinux 认证。

所有受测试平台默认使用发行版原生软件包。不会移除现有的外部仓库文件，且该角色不会在不同软件源或主版本之间迁移已安装的服务器。在迁移现有的外部安装前，请先审查软件包管理器冲突。

外部仓库路径是通过 `mariadb_configure_repo: true` 显式启用的未测试选项。其旧版 `mariadb_version` 选择器既不是原生服务器版本，也不是对受支持上游版本的推荐。旧的硬编码镜像源并未覆盖所有当前发行版；请使用原生默认配置，或先独立验证仓库配置。

该角色会在写入配置文件前探测运行中服务器的版本和数据目录。这会保留 Ubuntu 26.04 的 `/var/lib/mariadb` 及现有数据库存储。显式指定冲突的 `mariadb_data_dir` 会因需要迁移而失败；该角色不会移动数据。公开的软件包、服务、套接字和配置文件覆盖选项仍然可用。

密码修改使用参数化语句，以便 MariaDB 强制执行其严格的密码验证插件。root 的私有客户端文件使用本地 Unix 套接字。未变更的账户会保留其权限和密码。

## 开发与测试

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

这些目标定义在 [Makefile](../../../Makefile) 中。Molecule 需要其驱动程序和测试依赖项。Docker 目标使用 [dev](../../../dev) 下的文件；基础 Docker 目标是 `make docker-test`，而不是 `make test-docker`。

## 文档、安全与许可证

- [配置示例](../../../docs/README.md)
- [贡献指南](../../../CONTRIBUTING.md)
- [安全策略](../../../SECURITY.md)
- [MIT 许可证](../../../LICENSE)
