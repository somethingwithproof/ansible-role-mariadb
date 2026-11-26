<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Українська** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · **Українська** · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Роль Ansible для MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Роль Ansible для встановлення MariaDB, створення баз даних і користувачів, а також налаштування необов'язкових завдань резервного копіювання й моніторингу. Роль відокремлює завдання встановлення, налаштування, перевірки та експлуатації, щоб кожне з них можна було переглядати незалежно.

## Можливості

| Напрям | Реалізація |
| --- | --- |
| Встановлення та налаштування | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml) і шаблони конфігурації |
| Перевірка вхідних даних і налаштування облікових записів | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Створення баз даних | [databases.yml](../../../tasks/databases.yml) |
| Налаштування реплікації | [replication.yml](../../../tasks/replication.yml) задає ідентифікатори серверів і параметри бінарного журналювання та користувачів на основному сервері |
| Планове резервне копіювання | [backup.yml](../../../tasks/backup.yml) і [шаблон скрипту резервного копіювання](../../../templates/mariadb_backup.sh.j2) |
| Моніторинг | [monitoring.yml](../../../tasks/monitoring.yml) та шаблони експортера й перевірок |

Додані до репозиторію завдання реплікації не реалізують автоматичного аварійного перемикання або повної ініціалізації реплік. Кілька інстансів Molecule є тестовою топологією, а не підтвердженням розгортання кількох інстансів на одному хості. Перевірте шифрування резервних копій, поведінку під час відновлення та сумісність версій бази даних для вашого середовища; цей README їх не гарантує.

## Встановлення та використання

```bash
ansible-galaxy role install git+https://github.com/somethingwithproof/ansible-role-mariadb.git
ansible-galaxy collection install community.mysql
```

```yaml
- hosts: database_servers
  become: true
  vars:
    mariadb_configure_repo: false
    mariadb_allow_remote_connections: true
    mariadb_bind_address: "{{ ansible_facts.default_ipv4.address }}"
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

Передавайте зазначені змінні паролів через Ansible Vault або вашу систему керування секретами. Актуальні назви параметрів і значення за замовчуванням дивіться в [defaults/main.yml](../../../defaults/main.yml).

## Вимоги та сумісність

Поточний контролер — Ansible 14.5.0 / ansible-core 2.21.5 із Python 3.13. Сценарій `lts` перевіряє системні пакети дистрибутивів на Ubuntu 22.04, 24.04 і 26.04, Debian 12 і 13, а також Rocky Linux 9 і 10. Псевдоніми EL у метаданих не означають окремої сертифікації RHEL або AlmaLinux.

Системні пакети дистрибутива використовуються за замовчуванням на кожній протестованій платформі. Наявні файли зовнішніх репозиторіїв не видаляються, а роль не виконує міграцію встановленого сервера між джерелами пакетів або основними версіями. Перед міграцією наявного зовнішнього встановлення перевірте конфлікти пакетного менеджера.

Шлях із зовнішнім репозиторієм є явним, непротестованим параметром, який вмикається через `mariadb_configure_repo: true`. Застарілий селектор `mariadb_version` не визначає версію системного сервера й не є рекомендацією підтримуваного апстрім-релізу. Старі жорстко задані дзеркала не охоплюють усі сучасні дистрибутиви; використовуйте системні пакети за замовчуванням або спершу самостійно перевірте конфігурацію репозиторію.

Перед записом конфігурації роль визначає версію запущеного сервера та його каталог даних. Це зберігає каталог `/var/lib/mariadb` в Ubuntu 26.04 та наявне сховище баз даних. Явне задання конфліктного параметра `mariadb_data_dir` завершується помилкою з вимогою міграції; роль не переміщує дані. Публічні перевизначення пакетів, служб, сокетів і файлів конфігурації залишаються доступними.

Зміна паролів виконується за допомогою параметризованих запитів, щоб MariaDB могла застосовувати свій суворий плагін перевірки паролів. Приватний клієнтський файл root використовує локальний Unix-сокет. Незмінені облікові записи зберігають свої привілеї та паролі.

## Розробка та тестування

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Ці цілі визначено в [Makefile](../../../Makefile). Molecule потребує власного драйвера та тестових залежностей. Цілі Docker використовують файли в каталозі [dev](../../../dev); базовою ціллю Docker є `make docker-test`, а не `make test-docker`.

## Документація, безпека та ліцензія

- [Приклади конфігурації](../../../docs/README.md)
- [Участь у розробці](../../../CONTRIBUTING.md)
- [Політика безпеки](../../../SECURITY.md)
- [Ліцензія MIT](../../../LICENSE)
