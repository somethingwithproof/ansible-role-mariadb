<!-- translations:start -->
**Languages:** [English](../../../README.md) · **العربية (المغرب)** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · **العربية (المغرب)** · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# دور Ansible لـ MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

دور Ansible باش تثبت MariaDB، وتجهز قواعد البيانات والمستخدمين، وتضبط مهام النسخ الاحتياطي والمراقبة الاختيارية. هاد الدور كيفصل بين التثبيت، والإعداد، والتحقق، والمهام التشغيلية باش تقدر تراجع كل وحدة بوحدها.

## القدرات

| المجال | التنفيذ |
| --- | --- |
| التثبيت والإعداد | [install.yml](../../../tasks/install.yml)، [configure.yml](../../../tasks/configure.yml)، وقوالب الإعداد |
| التحقق من المدخلات وإعداد الحسابات | [validate.yml](../../../tasks/validate.yml)، [secure.yml](../../../tasks/secure.yml)، [users.yml](../../../tasks/users.yml) |
| تجهيز قواعد البيانات | [databases.yml](../../../tasks/databases.yml) |
| إعدادات النسخ المتماثل (Replication) | [replication.yml](../../../tasks/replication.yml) كيضبط معرفات السيرفر وإعدادات السجل الثنائي (binary logging) والمستخدم فالسيرفر الأساسي |
| النسخ الاحتياطي المجدول | [backup.yml](../../../tasks/backup.yml) و[قالب سكريبت النسخ الاحتياطي](../../../templates/mariadb_backup.sh.j2) |
| المراقبة | [monitoring.yml](../../../tasks/monitoring.yml) وقوالب المصدر (exporter) والفحص |

مهام النسخ المتماثل المرفقة ما كتنفذش التحويل التلقائي عند الفشل (failover) ولا التهيئة الكاملة للنسخة التابعة (replica). وجود عدة نسخ ديال Molecule هو غير طوبولوجيا للاختبار، ماشي دليل على نشر عدة نسخ على مضيف واحد. خاصك تراجع تشفير النسخ الاحتياطي، وسلوك الاسترجاع، وتوافق إصدار قاعدة البيانات مع النشر ديالك؛ هادشي ما مضمونش فهاد الـ README.

## التثبيت والاستعمال

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

وفر متغيرات كلمات السر المشار ليها عبر Ansible Vault ولا نظام إدارة الأسرار ديالك. استعمل [defaults/main.yml](../../../defaults/main.yml) باش تشوف سميات الخيارات الحقيقية والقيم الافتراضية ديالها.

## المتطلبات والتوافق

المتحكم (controller) الحالي هو Ansible 14.5.0 / ansible-core 2.21.5 مع Python 3.13. سيناريو `lts` كيختبر الحزم الأصلية ديال التوزيعات على Ubuntu 22.04 و24.04 و26.04، وDebian 12 و13، وRocky Linux 9 و10. الأسماء البديلة ديال EL فالبيانات الوصفية ما كتعنيش شهادة مستقلة لـ RHEL ولا AlmaLinux.

الحزم الأصلية ديال التوزيعة هي الافتراضية على كل منصة مجربة. ملفات المستودعات الخارجية اللي ديجا كاينة ما كتتمسحش، والدور ما كيهجرش سيرفر مثبت ديجا بين مصادر حزم ولا إصدارات رئيسية. راجع تعارضات مدير الحزم قبل ما تهجر أي تثبيت خارجي موجود.

مسار المستودع الخارجي هو خيار صريح وما مجربش كتفعلو عبر `mariadb_configure_repo: true`. محدد `mariadb_version` القديم ماشي إصدار للسيرفر الأصلي وماشي توصية لإصدار مدعوم من المنبع (upstream). المرايا القديمة المثبتة فالكود ما كتغطيش كل التوزيعات الحالية؛ استعمل الإعداد الافتراضي الأصلي ولا تحقق بشكل مستقل من إعدادات المستودع قبل ما تستعملو.

الدور كيكتشف إصدار السيرفر اللي خدام ومجلد البيانات قبل ما يكتب الإعدادات. هادشي كيحافظ على `/var/lib/mariadb` فـ Ubuntu 26.04 وعلى تخزين قاعدة البيانات الموجود ديجا. أي تعارض صريح فـ `mariadb_data_dir` كيفشل مع طلب ترحيل؛ الدور ما كينقلش البيانات. التجاوزات العمومية ديال الحزم، والخدمة، والـ socket، وملفات الإعداد كتبقى متوفرة.

تغييرات كلمات السر كتستعمل عبارات بمعاملات (parameterized statements) باش MariaDB يقدر يفرض إضافة التحقق الصارم من كلمة السر. ملف العميل الخاص ديال root كيستعمل Unix socket المحلي. الحسابات اللي ما تبدلاتش كتحتافظ بالصلاحيات وكلمات السر ديالها.

## التطوير والاختبار

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

هاد الأهداف محددة فـ [Makefile](../../../Makefile). Molecule كيحتاج السائق (driver) ديالو وتبعيات الاختبار. أهداف Docker كتستعمل ملفات تحت [dev](../../../dev)؛ الأمر الأساسي ديال Docker هو `make docker-test`، ماشي `make test-docker`.

## الوثائق والأمان والرخصة

- [أمثلة الإعدادات](../../../docs/README.md)
- [المساهمة](../../../CONTRIBUTING.md)
- [سياسة الأمان](../../../SECURITY.md)
- [رخصة MIT](../../../LICENSE)
