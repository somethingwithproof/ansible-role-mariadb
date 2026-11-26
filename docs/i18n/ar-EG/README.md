<!-- translations:start -->
**Languages:** [English](../../../README.md) · **العربية (مصر)** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · **العربية (مصر)** · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# دور MariaDB لـ Ansible

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

دور (role) لـ Ansible علشان تثبّت MariaDB، وتجهّز قواعد البيانات والمستخدمين، وتضبط مهام اختيارية للنسخ الاحتياطي والمراقبة. الدور بيفصل التثبيت والإعدادات والتحقق والمهام التشغيلية علشان تقدر تراجع كل جزء لوحده.

## القدرات

| المجال | التنفيذ |
| --- | --- |
| التثبيت والإعدادات | [install.yml](../../../tasks/install.yml)، و[configure.yml](../../../tasks/configure.yml)، وقوالب الإعدادات |
| التحقق من المدخلات وإعداد الحسابات | [validate.yml](../../../tasks/validate.yml)، و[secure.yml](../../../tasks/secure.yml)، و[users.yml](../../../tasks/users.yml) |
| تجهيز قواعد البيانات | [databases.yml](../../../tasks/databases.yml) |
| إعدادات النسخ المتماثل (Replication) | [replication.yml](../../../tasks/replication.yml) بيضبط أرقام السيرفرات (server IDs) وإعدادات الـ binary logging والمستخدمين على السيرفر الأساسي |
| النسخ الاحتياطي المجدول | [backup.yml](../../../tasks/backup.yml) و[قالب سكربت النسخ الاحتياطي](../../../templates/mariadb_backup.sh.j2) |
| المراقبة | [monitoring.yml](../../../tasks/monitoring.yml) وقوالب الـ exporter والفحوصات |

مهام الـ replication الموجودة في المستودع مش بتنفّذ failover تلقائي أو تهيئة كاملة للـ replica. وجود أكتر من نسخة Molecule ده مجرد هيكل اختبار (test topology)، مش دليل على دعم تشغيل أكتر من نسخة على نفس السيرفر. راجع تشفير النسخ الاحتياطية، وسلوك الاستعادة، وتوافق إصدار قاعدة البيانات مع بيئة النشر بتاعتك؛ الحاجات دي مش مضمونة في ملف الـ README ده.

## التثبيت والاستخدام

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

وفّر متغيرات كلمات المرور المذكورة عن طريق Ansible Vault أو نظام إدارة الأسرار اللي بتستخدمه. راجع [defaults/main.yml](../../../defaults/main.yml) علشان تعرف أسماء الخيارات الفعلية والقيم الافتراضية بتاعتها.

## المتطلبات والتوافق

الـ controller الحالي هو Ansible 14.5.0 / ansible-core 2.21.5 مع Python 3.13. سيناريو `lts` بيجرّب حزم التوزيعة الأصلية على Ubuntu 22.04 و24.04 و26.04، وDebian 12 و13، وRocky Linux 9 و10. أسماء EL البديلة في البيانات الوصفية مش معناها شهادة اعتماد منفصلة لـ RHEL أو AlmaLinux.

حزم التوزيعة الأصلية هي الخيار الافتراضي على كل منصة متجرّبة. ملفات المستودعات الخارجية الموجودة قبل كده مش بتتمسح، والدور مش بيعمل ترحيل لسيرفر متثبّت بين مصادر حزم أو إصدارات رئيسية. راجع تعارضات مدير الحزم قبل ما ترحّل تثبيت خارجي موجود بالفعل.

مسار المستودع الخارجي هو اختيار صريح وغير متجرّب عن طريق `mariadb_configure_repo: true`. محدد `mariadb_version` القديم مش إصدار لسيرفر التوزيعة الأصلي ومش توصية لإصدار upstream مدعوم. المرايا (mirrors) القديمة المكتوبة ثابتة في الكود مش بتغطي كل التوزيعات الحالية؛ استخدم الخيار الافتراضي الأصلي أو اتأكد بنفسك من إعدادات المستودع الأول.

الدور بيكتشف إصدار السيرفر الشغّال ومجلد البيانات قبل ما يكتب الإعدادات. ده بيحافظ على `/var/lib/mariadb` في Ubuntu 26.04 وعلى تخزين قواعد البيانات الموجود. لو حدّدت `mariadb_data_dir` مختلف ومتعارض، التنفيذ هيفشل ويطلب ترحيل؛ الدور مش بينقل البيانات. خيارات تخصيص الحزمة، والخدمة، والـ socket، وملف الإعدادات لسه متاحة.

تغييرات كلمات المرور بتستخدم parameterized statements علشان MariaDB يقدر يطبّق إضافة التحقق الصارم من كلمات المرور. ملف العميل الخاص بمستخدم root بيستخدم الـ Unix socket المحلي. الحسابات اللي ما اتغيّرتش بتحتفظ بصلاحياتها وكلمات مرورها.

## التطوير والاختبار

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

الأهداف (targets) دي متعرّفة في [Makefile](../../../Makefile). أداة Molecule بتحتاج الـ driver وتبعيات الاختبار بتاعتها. أهداف Docker بتستخدم ملفات تحت [dev](../../../dev)؛ والهدف الأساسي لـ Docker هو `make docker-test`، مش `make test-docker`.

## التوثيق والأمان والرخصة

- [أمثلة الإعدادات](../../../docs/README.md)
- [المساهمة](../../../CONTRIBUTING.md)
- [سياسة الأمان](../../../SECURITY.md)
- [رخصة MIT](../../../LICENSE)
