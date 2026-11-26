<!-- translations:start -->
**Languages:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · **日本語** · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · **日本語** · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# MariaDB Ansible ロール

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

MariaDB のインストール、データベースおよびユーザーのプロビジョニング、さらにオプションのバックアップや監視タスクの設定を行うための Ansible ロールです。インストール、設定、検証、および運用タスクを分離しているため、それぞれを個別にレビューできます。

## 機能一覧

| 領域 | 実装 |
| --- | --- |
| インストールと設定 | [install.yml](../../../tasks/install.yml)、[configure.yml](../../../tasks/configure.yml)、および設定テンプレート |
| 入力検証とアカウント設定 | [validate.yml](../../../tasks/validate.yml)、[secure.yml](../../../tasks/secure.yml)、[users.yml](../../../tasks/users.yml) |
| データベースのプロビジョニング | [databases.yml](../../../tasks/databases.yml) |
| レプリケーション設定 | [replication.yml](../../../tasks/replication.yml) によりサーバー ID およびプライマリ側のバイナリログ・ユーザー設定を構成 |
| スケジュールバックアップ | [backup.yml](../../../tasks/backup.yml) および [バックアップスクリプトテンプレート](../../../templates/mariadb_backup.sh.j2) |
| 監視 | [monitoring.yml](../../../tasks/monitoring.yml) およびエクスポーター・チェック用テンプレート |

リポジトリに含まれるレプリケーションタスクは、自動フェイルオーバーや完全なレプリカ初期化を実装するものではありません。複数の Molecule インスタンスはテスト用トポロジーであり、単一ホスト上でのマルチインスタンス構成を保証する根拠にはなりません。バックアップの暗号化、リストア動作、およびデータベースバージョンの互換性については、ご自身のデプロイ環境に合わせて確認してください。これらはこの README によって保証されるものではありません。

## インストールと使用方法

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

参照されるパスワード変数は、Ansible Vault またはご利用のシークレット管理システムを通じて提供してください。実際のオプション名とデフォルト値については、[defaults/main.yml](../../../defaults/main.yml) を参照してください。

## 要件と互換性

現在のコントローラー環境は Python 3.13 上の Ansible 14.5.0 / ansible-core 2.21.5 です。`lts` シナリオでは、Ubuntu 22.04、24.04、26.04、Debian 12 および 13、Rocky Linux 9 および 10 上でディストリビューション標準パッケージを検証しています。メタデータ内の EL エイリアスは、RHEL や AlmaLinux に対する個別の認定を意味するものではありません。

テスト対象のすべてのプラットフォームで、ディストリビューション標準パッケージがデフォルトです。既存の外部リポジトリファイルは削除されず、本ロールはインストール済みのサーバーをパッケージソース間やメジャーバージョン間で移行しません。既存の外部インストールから移行する前に、パッケージマネージャーの競合を確認してください。

外部リポジトリを使用する経路は、`mariadb_configure_repo: true` による明示的かつ未テストのオプトイン機能です。従来の `mariadb_version` セレクターは標準サーバーのバージョンではなく、サポートされているアップストリームリリースの推奨値でもありません。古いハードコードされたミラーは現行のすべてのディストリビューションに対応していないため、標準パッケージのデフォルトを使用するか、事前にリポジトリ設定を独自に検証してください。

本ロールは設定を書き込む前に、稼働中のサーバーのバージョンとデータディレクトリを検出します。これにより、Ubuntu 26.04 の `/var/lib/mariadb` および既存のデータベースストレージが保持されます。競合する `mariadb_data_dir` が明示的に指定された場合は移行が必要であるとして失敗し、ロールによるデータ移動は行いません。公開されているパッケージ、サービス、ソケット、および設定ファイルの上書きオプションは引き続き利用可能です。

パスワード変更にはパラメータ化されたステートメントを使用するため、MariaDB の厳格なパスワード検証プラグインを適用できます。root 用のプライベートクライアントファイルはローカルの Unix ソケットを使用します。変更のないアカウントでは、既存の権限とパスワードが保持されます。

## 開発とテスト

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

これらのターゲットは [Makefile](../../../Makefile) で定義されています。Molecule の実行にはドライバーとテスト依存関係が必要です。Docker ターゲットは [dev](../../../dev) 配下のファイルを使用します。基本的な Docker ターゲットは `make test-docker` ではなく `make docker-test` です。

## ドキュメント、セキュリティ、ライセンス

- [設定例](../../../docs/README.md)
- [コントリビューション](../../../CONTRIBUTING.md)
- [セキュリティポリシー](../../../SECURITY.md)
- [MIT ライセンス](../../../LICENSE)
