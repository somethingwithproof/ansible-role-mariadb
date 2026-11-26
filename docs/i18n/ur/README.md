<!-- translations:start -->
**Languages:** [English](../../../README.md) · **اردو** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · **اردو** · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# MariaDB Ansible Role

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

MariaDB انسٹال کرنے، ڈیٹا بیسز اور صارفین کی فراہمی (provisioning)، اور اختیاری بیک اپ و مانیٹرنگ ٹاسکس کنفیگر کرنے کے لیے ایک Ansible رول۔ یہ رول انسٹالیشن، کنفیگریشن، توثیق، اور آپریشنل ٹاسکس کو الگ رکھتا ہے تاکہ ہر ایک کا آزادانہ جائزہ لیا جا سکے۔

## صلاحیتیں

| شعبہ | نفاذ |
| --- | --- |
| انسٹالیشن اور کنفیگریشن | [install.yml](../../../tasks/install.yml)، [configure.yml](../../../tasks/configure.yml)، اور کنفیگریشن ٹیمپلیٹس |
| ان پٹ کی توثیق اور اکاؤنٹ سیٹ اپ | [validate.yml](../../../tasks/validate.yml)، [secure.yml](../../../tasks/secure.yml)، [users.yml](../../../tasks/users.yml) |
| ڈیٹا بیس کی فراہمی | [databases.yml](../../../tasks/databases.yml) |
| ریپلیکیشن کی ترتیبات | [replication.yml](../../../tasks/replication.yml) سرور IDs اور پرائمری سائیڈ بائنری لاگنگ/صارف کی ترتیبات متعین کرتا ہے |
| شیڈول کردہ بیک اپس | [backup.yml](../../../tasks/backup.yml) اور [بیک اپ اسکرپٹ ٹیمپلیٹ](../../../templates/mariadb_backup.sh.j2) |
| مانیٹرنگ | [monitoring.yml](../../../tasks/monitoring.yml) اور ایکسپورٹر/چیک ٹیمپلیٹس |

ریپوزیٹری میں موجود ریپلیکیشن ٹاسکس خودکار فیل اوور یا مکمل ریپلیکا انیشیلائزیشن کا نفاذ نہیں کرتے۔ متعدد Molecule انسٹنسز ایک ٹیسٹ ٹوپولوجی ہیں، ایک ہی ہوسٹ پر ملٹی انسٹنس تعیناتی کا ثبوت نہیں۔ اپنی تعیناتی کے لیے بیک اپ انکرپشن، بحالی (restore) کے رویے، اور ڈیٹا بیس ورژن کی مطابقت کا جائزہ لیں؛ اس README میں ان کی ضمانت نہیں دی گئی۔

## انسٹالیشن اور استعمال

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

حوالہ دیے گئے پاس ورڈ متغیرات کو Ansible Vault یا اپنے سیکرٹ مینجمنٹ سسٹم کے ذریعے فراہم کریں۔ اصل آپشن ناموں اور ڈیفالٹس کے لیے [defaults/main.yml](../../../defaults/main.yml) دیکھیں۔

## تقاضے اور مطابقت

موجودہ کنٹرولر Python 3.13 کے ساتھ Ansible 14.5.0 / ansible-core 2.21.5 ہے۔ `lts` منظرنامہ Ubuntu 22.04، 24.04 اور 26.04، Debian 12 اور 13، اور Rocky Linux 9 اور 10 پر مقامی ڈسٹری بیوشن پیکیجز کی جانچ کرتا ہے۔ میٹا ڈیٹا میں موجود EL ایلیئسز (aliases) علیحدہ RHEL یا AlmaLinux سرٹیفیکیشن ثابت نہیں کرتے۔

ہر ٹیسٹ شدہ پلیٹ فارم پر مقامی ڈسٹری بیوشن پیکیجز بطورِ ڈیفالٹ استعمال ہوتے ہیں۔ موجودہ بیرونی ریپوزیٹری فائلوں کو حذف نہیں کیا جاتا، اور یہ رول پہلے سے انسٹال شدہ سرور کو پیکیج سورسز یا بڑے (major) ورژنز کے درمیان منتقل (migrate) نہیں کرتا۔ کسی موجودہ بیرونی انسٹالیشن کو منتقل کرنے سے پہلے پیکیج مینیجر کے تضادات کا جائزہ لیں۔

بیرونی ریپوزیٹری کا راستہ `mariadb_configure_repo: true` کے ذریعے ایک واضح، غیر ٹیسٹ شدہ آپٹ ان (opt-in) ہے۔ اس کا پرانا `mariadb_version` سیلیکٹر مقامی سرور ورژن یا کسی سپورٹ شدہ اپ اسٹریم ریلیز کی سفارش نہیں ہے۔ پرانے ہارڈ کوڈڈ مررز ہر موجودہ ڈسٹری بیوشن کا احاطہ نہیں کرتے؛ مقامی ڈیفالٹ استعمال کریں یا پہلے آزادانہ طور پر ریپوزیٹری کنفیگریشن کی اہلیت جانچ لیں۔

کنفیگریشن لکھنے سے پہلے یہ رول چلتے ہوئے سرور کا ورژن اور ڈیٹا ڈائریکٹری معلوم کرتا ہے۔ اس سے Ubuntu 26.04 کی `/var/lib/mariadb` اور موجودہ ڈیٹا بیس اسٹوریج محفوظ رہتی ہے۔ ایک واضح متصادم `mariadb_data_dir` منتقلی (migration) کی شرط کے ساتھ ناکام ہو جاتا ہے؛ یہ رول ڈیٹا منتقل نہیں کرتا۔ عوامی پیکیج، سروس، ساکٹ اور کنفیگریشن فائل اوور رائیڈز بدستور دستیاب ہیں۔

پاس ورڈ کی تبدیلیوں میں پیرامیٹرائزڈ اسٹیٹمنٹس استعمال ہوتی ہیں تاکہ MariaDB اپنا سخت پاس ورڈ توثیقی پلگ ان نافذ کر سکے۔ Root کی نجی کلائنٹ فائل مقامی Unix ساکٹ استعمال کرتی ہے۔ غیر تبدیل شدہ اکاؤنٹس اپنے گرانٹس اور پاس ورڈز برقرار رکھتے ہیں۔

## ڈیولپمنٹ اور ٹیسٹنگ

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

یہ ٹارگٹس [Makefile](../../../Makefile) میں بیان کیے گئے ہیں۔ Molecule کے لیے اس کا ڈرائیور اور ٹیسٹ ڈیپینڈنسیز درکار ہیں۔ Docker ٹارگٹس [dev](../../../dev) کے تحت موجود فائلیں استعمال کرتے ہیں؛ بنیادی Docker ٹارگٹ `make docker-test` ہے، نہ کہ `make test-docker`۔

## دستاویزات، سیکیورٹی، اور لائسنس

- [کنفیگریشن کی مثالیں](../../../docs/README.md)
- [تعاون](../../../CONTRIBUTING.md)
- [سیکیورٹی پالیسی](../../../SECURITY.md)
- [MIT لائسنس](../../../LICENSE)
