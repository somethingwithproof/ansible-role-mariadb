<!-- translations:start -->
**Languages:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · **Русский** · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · **Русский** · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Роль Ansible для MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Роль Ansible для установки MariaDB, создания баз данных и пользователей, а также настройки опциональных задач резервного копирования и мониторинга. Роль разделяет задачи установки, настройки, проверки и эксплуатации, чтобы каждую из них можно было анализировать независимо.

## Возможности

| Область | Реализация |
| --- | --- |
| Установка и настройка | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml) и шаблоны конфигурации |
| Проверка входных данных и настройка учётных записей | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Подготовка баз данных | [databases.yml](../../../tasks/databases.yml) |
| Настройки репликации | [replication.yml](../../../tasks/replication.yml) задаёт идентификаторы серверов, параметры бинарного логирования и учётные записи на стороне первичного узла |
| Резервное копирование по расписанию | [backup.yml](../../../tasks/backup.yml) и [шаблон скрипта резервного копирования](../../../templates/mariadb_backup.sh.j2) |
| Мониторинг | [monitoring.yml](../../../tasks/monitoring.yml) и шаблоны экспортёров/проверок |

Зафиксированные в репозитории задачи репликации не реализуют автоматическое аварийное переключение или полную инициализацию реплики. Несколько экземпляров Molecule представляют собой тестовую топологию, а не подтверждение развёртывания нескольких экземпляров на одном хосте. Проверьте шифрование резервных копий, поведение при восстановлении и совместимость версий базы данных для вашего развёртывания; данный README их не гарантирует.

## Установка и использование

```bash
ansible-galaxy role install git+https://github.com/somethingwithproof/ansible-role-mariadb.git
ansible-galaxy collection install community.mysql
```

```yaml
# inventory.yml
database_servers:
  hosts:
    db01:
      database_network_address: "192.168.0.10"
```

```yaml
- hosts: database_servers
  become: true
  vars:
    mariadb_configure_repo: false
    mariadb_allow_remote_connections: true
    mariadb_bind_address: "{{ database_network_address }}"
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

Передавайте указанные переменные паролей через Ansible Vault или вашу систему управления секретами. Актуальные имена параметров и значения по умолчанию приведены в [defaults/main.yml](../../../defaults/main.yml).

## Требования и совместимость

Текущий управляющий узел использует Ansible 14.5.0 / ansible-core 2.21.5 с Python 3.13. Сценарий `lts` проверяет нативные пакеты дистрибутивов на Ubuntu 22.04, 24.04 и 26.04, Debian 12 и 13, а также Rocky Linux 9 и 10. Псевдонимы EL в метаданных не означают отдельную сертификацию для RHEL или AlmaLinux.

Нативные пакеты дистрибутива используются по умолчанию на всех протестированных платформах. Существующие файлы внешних репозиториев не удаляются, и роль не выполняет миграцию установленного сервера между источниками пакетов или мажорными версиями. Проверьте конфликты пакетного менеджера перед миграцией существующей внешней установки.

Использование внешнего репозитория включается явно и не тестируется — через параметр `mariadb_configure_repo: true`. Его устаревший селектор `mariadb_version` не определяет версию нативного сервера и не является рекомендацией по выбору поддерживаемого upstream-релиза. Старые жёстко заданные зеркала охватывают не все актуальные дистрибутивы; используйте нативный вариант по умолчанию либо предварительно самостоятельно проверьте конфигурацию репозитория.

Перед записью конфигурации роль определяет версию запущенного сервера и каталог данных. Это сохраняет каталог `/var/lib/mariadb` в Ubuntu 26.04 и существующее хранилище баз данных. Явное указание конфликтующего параметра `mariadb_data_dir` завершается ошибкой с требованием миграции; роль не перемещает данные. Публичные переопределения пакетов, служб, сокетов и файлов конфигурации остаются доступными.

Смена паролей выполняется с помощью параметризованных запросов, чтобы MariaDB могла применять свой строгий плагин проверки паролей. Закрытый клиентский файл root использует локальный Unix-сокет. Неизменённые учётные записи сохраняют свои права доступа и пароли.

## Разработка и тестирование

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Эти цели определены в [Makefile](../../../Makefile). Для работы Molecule требуются её драйвер и тестовые зависимости. Цели Docker используют файлы в каталоге [dev](../../../dev); базовой целью Docker является `make docker-test`, а не `make test-docker`.

## Документация, безопасность и лицензия

- [Примеры конфигурации](../../../docs/README.md)
- [Участие в разработке](../../../CONTRIBUTING.md)
- [Политика безопасности](../../../SECURITY.md)
- [Лицензия MIT](../../../LICENSE)
