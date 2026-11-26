<!-- translations:start -->
**Languages:** [English](../../../README.md) · **繁體中文** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · **繁體中文** · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# MariaDB Ansible 角色

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

用於安裝 MariaDB、佈建資料庫與使用者，並設定選用備份與監控工作的 Ansible 角色。此角色將安裝、設定、驗證與維運工作分離，使每個階段都能獨立檢視。

## 功能

| 領域 | 實作方式 |
| --- | --- |
| 安裝與設定 | [install.yml](../../../tasks/install.yml)、[configure.yml](../../../tasks/configure.yml) 以及設定檔範本 |
| 輸入驗證與帳號設定 | [validate.yml](../../../tasks/validate.yml)、[secure.yml](../../../tasks/secure.yml)、[users.yml](../../../tasks/users.yml) |
| 資料庫佈建 | [databases.yml](../../../tasks/databases.yml) |
| 複寫設定 | [replication.yml](../../../tasks/replication.yml) 負責設定伺服器 ID 以及主節點端的二進位日誌／使用者設定 |
| 排程備份 | [backup.yml](../../../tasks/backup.yml) 與[備份腳本範本](../../../templates/mariadb_backup.sh.j2) |
| 監控 | [monitoring.yml](../../../tasks/monitoring.yml) 與 exporter／檢查範本 |

已納入版本的複寫工作並未實作自動容錯移轉或完整的複本初始化。多個 Molecule 執行個體僅為測試拓撲，並非單一主機上多執行個體部署的證明。請針對您的部署環境檢視備份加密、還原行為與資料庫版本相容性；本 README 不對這些項目提供保證。

## 安裝與使用

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

請透過 Ansible Vault 或您的機密管理系統提供所參照的密碼變數。實際的選項名稱與預設值請參閱 [defaults/main.yml](../../../defaults/main.yml)。

## 需求與相容性

目前的控制器環境為 Ansible 14.5.0 / ansible-core 2.21.5 搭配 Python 3.13。`lts` 情境會在 Ubuntu 22.04、24.04 與 26.04、Debian 12 與 13，以及 Rocky Linux 9 與 10 上測試發行版原生套件。中繼資料中的 EL 別名不代表獨立的 RHEL 或 AlmaLinux 認證。

在所有受測平台上，皆預設使用發行版原生套件。既有的外部套件庫設定檔不會被移除，且此角色不會在套件來源或主要版本之間遷移已安裝的伺服器。遷移既有的外部安裝前，請先檢視套件管理程式的衝突。

外部套件庫路徑是透過 `mariadb_configure_repo: true` 明確啟用且未經測試的選項。其舊版 `mariadb_version` 選擇器既非原生伺服器版本，也不是受支援上游發行版本的建議。舊的硬編碼鏡像站並未涵蓋所有現行發行版；請使用原生預設值，或先獨立驗證套件庫設定。

此角色會在寫入設定檔之前，先偵測執行中伺服器的版本與資料目錄。這可保留 Ubuntu 26.04 的 `/var/lib/mariadb` 以及既有的資料庫儲存空間。若明確指定了衝突的 `mariadb_data_dir`，角色將會失敗並要求進行遷移；此角色不會搬移資料。公開的套件、服務、socket 與設定檔覆寫選項仍可正常使用。

密碼變更採用參數化陳述式，以便 MariaDB 強制執行其嚴格的密碼驗證外掛程式。Root 的私密用戶端檔案使用本機 Unix socket。未變更的帳號將保留其權限授與（grants）與密碼。

## 開發與測試

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

這些目標定義於 [Makefile](../../../Makefile)。Molecule 需要其驅動程式與測試相依套件。Docker 目標使用 [dev](../../../dev) 底下的檔案；基本 Docker 測試目標為 `make docker-test`，而非 `make test-docker`。

## 文件、安全性與授權

- [設定範例](../../../docs/README.md)
- [貢獻指南](../../../CONTRIBUTING.md)
- [安全性政策](../../../SECURITY.md)
- [MIT 授權條款](../../../LICENSE)
