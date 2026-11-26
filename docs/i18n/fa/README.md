<!-- translations:start -->
**Languages:** [English](../../../README.md) · **فارسی** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · **فارسی** · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# نقش Ansible برای MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

نقشی از Ansible برای نصب MariaDB، ایجاد پایگاه‌های داده و کاربران، و پیکربندی وظایف اختیاری پشتیبان‌گیری و پایش. این نقش وظایف نصب، پیکربندی، اعتبارسنجی و عملیاتی را از هم جدا می‌کند تا هر بخش به‌صورت مستقل قابل بررسی باشد.

## قابلیت‌ها

| حوزه | پیاده‌سازی |
| --- | --- |
| نصب و پیکربندی | [install.yml](../../../tasks/install.yml)، [configure.yml](../../../tasks/configure.yml) و قالب‌های پیکربندی |
| اعتبارسنجی ورودی و راه‌اندازی حساب‌ها | [validate.yml](../../../tasks/validate.yml)، [secure.yml](../../../tasks/secure.yml)، [users.yml](../../../tasks/users.yml) |
| ایجاد و تخصیص پایگاه داده | [databases.yml](../../../tasks/databases.yml) |
| تنظیمات تکثیر (Replication) | [replication.yml](../../../tasks/replication.yml) شناسه‌های سرور و تنظیمات binary logging و کاربر سمت سرور اصلی را تنظیم می‌کند |
| پشتیبان‌گیری زمان‌بندی‌شده | [backup.yml](../../../tasks/backup.yml) و [قالب اسکریپت پشتیبان‌گیری](../../../templates/mariadb_backup.sh.j2) |
| پایش | [monitoring.yml](../../../tasks/monitoring.yml) و قالب‌های exporter و بررسی |

وظایف تکثیر موجود در مخزن، انتقال خودکار هنگام خطا (failover) یا مقداردهی اولیه کامل replica را پیاده‌سازی نمی‌کنند. وجود چند نمونه Molecule یک توپولوژی آزمایشی است و شواهدی برای استقرار چندنمونه‌ای روی یک میزبان محسوب نمی‌شود. رمزنگاری پشتیبان‌ها، رفتار بازیابی و سازگاری نسخه پایگاه داده را برای استقرار خود بررسی کنید؛ این موارد در این README تضمین نشده‌اند.

## نصب و استفاده

```bash
ansible-galaxy role install git+https://github.com/somethingwithproof/ansible-role-mariadb.git
ansible-galaxy collection install community.mysql
```

```yaml
# inventory.yml
database_servers:
  hosts:
    db01:
      ansible_host: "192.168.0.10"
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

متغیرهای رمز عبور ارجاع‌شده را از طریق Ansible Vault یا سامانه مدیریت اسرار خود تأمین کنید. برای نام‌های واقعی گزینه‌ها و مقادیر پیش‌فرض، به [defaults/main.yml](../../../defaults/main.yml) مراجعه کنید.

## نیازمندی‌ها و سازگاری

کنترلر فعلی Ansible 14.5.0 / ansible-core 2.21.5 همراه با Python 3.13 است. سناریوی `lts` بسته‌های بومی توزیع را روی Ubuntu 22.04، 24.04 و 26.04، Debian 12 و 13 و Rocky Linux 9 و 10 آزمایش می‌کند. نام‌های مستعار EL در فراداده به معنای گواهی جداگانه برای RHEL یا AlmaLinux نیستند.

بسته‌های بومی توزیع به‌صورت پیش‌فرض روی تمام پلتفرم‌های آزمایش‌شده استفاده می‌شوند. فایل‌های مخازن خارجی موجود حذف نمی‌شوند و این نقش یک سرور نصب‌شده را میان منابع بسته یا نسخه‌های اصلی مهاجرت نمی‌دهد. پیش از مهاجرت یک نصب خارجی موجود، تعارض‌های مدیر بسته را بررسی کنید.

مسیر مخزن خارجی یک گزینه انتخابی صریح و آزمایش‌نشده از طریق `mariadb_configure_repo: true` است. انتخابگر قدیمی `mariadb_version` آن، نسخه سرور بومی یا توصیه‌ای برای یک انتشار پشتیبانی‌شده بالادستی نیست. آینه‌های (mirror) قدیمی که به‌صورت ثابت در کد قرار گرفته‌اند همه توزیع‌های فعلی را پوشش نمی‌دهند؛ از پیش‌فرض بومی استفاده کنید یا ابتدا پیکربندی مخزن را به‌صورت مستقل ارزیابی نمایید.

این نقش پیش از نوشتن پیکربندی، نسخه سرور در حال اجرا و دایرکتوری داده آن را کشف می‌کند. این کار مسیر `/var/lib/mariadb` در Ubuntu 26.04 و فضای ذخیره‌سازی پایگاه داده موجود را حفظ می‌کند. تنظیم صریح یک `mariadb_data_dir` متعارض با خطای نیاز به مهاجرت متوقف می‌شود؛ این نقش داده‌ها را جابه‌جا نمی‌کند. بازنویسی‌های عمومی بسته، سرویس، سوکت و فایل پیکربندی همچنان در دسترس هستند.

تغییر رمزهای عبور با دستورهای پارامتری انجام می‌شود تا MariaDB بتواند افزونه سخت‌گیرانه اعتبارسنجی رمز عبور خود را اعمال کند. فایل کلاینت خصوصی کاربر root از سوکت محلی Unix استفاده می‌کند. حساب‌های تغییرنکرده، مجوزها و رمزهای عبور خود را حفظ می‌کنند.

## توسعه و آزمون

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

این هدف‌ها در [Makefile](../../../Makefile) تعریف شده‌اند. Molecule به درایور و وابستگی‌های آزمون خود نیاز دارد. هدف‌های Docker از فایل‌های زیر [dev](../../../dev) استفاده می‌کنند؛ هدف پایه Docker دستور `make docker-test` است، نه `make test-docker`.

## مستندات، امنیت و مجوز

- [مثال‌های پیکربندی](../../../docs/README.md)
- [مشارکت](../../../CONTRIBUTING.md)
- [سیاست امنیتی](../../../SECURITY.md)
- [مجوز MIT](../../../LICENSE)
