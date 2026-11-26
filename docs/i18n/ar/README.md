<!-- translations:start -->
**Languages:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · **العربية** · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · **العربية** · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# دور Ansible لـ MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

دور Ansible لتثبيت MariaDB، وتوفير قواعد البيانات والمستخدمين، وتهيئة مهام النسخ الاحتياطي والمراقبة الاختيارية. يفصل الدور بين مهام التثبيت والتهيئة والتحقق والمهام التشغيلية بحيث يمكن مراجعة كل منها بصورة مستقلة.

## القدرات

| المجال | التنفيذ |
| --- | --- |
| التثبيت والتهيئة | [install.yml](../../../tasks/install.yml) و[configure.yml](../../../tasks/configure.yml) وقوالب التهيئة |
| التحقق من المدخلات وإعداد الحسابات | [validate.yml](../../../tasks/validate.yml) و[secure.yml](../../../tasks/secure.yml) و[users.yml](../../../tasks/users.yml) |
| توفير قواعد البيانات | [databases.yml](../../../tasks/databases.yml) |
| إعدادات النسخ المتماثل | يضبط [replication.yml](../../../tasks/replication.yml) معرّفات الخوادم وإعدادات السجل الثنائي والمستخدمين على الخادم الأساسي |
| النسخ الاحتياطية المجدولة | [backup.yml](../../../tasks/backup.yml) و[قالب نص النسخ الاحتياطي](../../../templates/mariadb_backup.sh.j2) |
| المراقبة | [monitoring.yml](../../../tasks/monitoring.yml) وقوالب المصدّر والفحوصات |

لا تنفّذ مهام النسخ المتماثل المُدرجة تجاوزَ فشل تلقائياً ولا تهيئةً كاملة للنسخة التابعة. وتمثّل مثيلات Molecule المتعددة طوبولوجيا اختبار فحسب، وليست دليلاً على نشر مثيلات متعددة على مضيف واحد. راجع تشفير النسخ الاحتياطية وسلوك الاستعادة وتوافق إصدارات قاعدة البيانات لبيئة النشر الخاصة بك؛ إذ لا يضمن ملف README هذا أياً منها.

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

زوّد متغيرات كلمات المرور المشار إليها عبر Ansible Vault أو نظام إدارة الأسرار لديك. وارجع إلى [defaults/main.yml](../../../defaults/main.yml) لمعرفة أسماء الخيارات الفعلية وقيمها الافتراضية.

## المتطلبات والتوافق

عقدة التحكم الحالية هي Ansible 14.5.0 / ansible-core 2.21.5 مع Python 3.13. يختبر سيناريو `lts` حزم التوزيعات الأصلية على Ubuntu 22.04 و24.04 و26.04، وDebian 12 و13، وRocky Linux 9 و10. ولا تُثبت الأسماء البديلة لـ EL في البيانات الوصفية اعتماداً منفصلاً لكل من RHEL أو AlmaLinux.

تُعدّ حزم التوزيعات الأصلية الخيار الافتراضي على كل منصة مختبرة. لا تُزال ملفات المستودعات الخارجية القائمة، ولا يرحّل الدور خادماً مثبّتاً بين مصادر الحزم أو الإصدارات الرئيسية. راجع تعارضات مدير الحزم قبل ترحيل تثبيت خارجي قائم.

يمثّل مسار المستودع الخارجي خياراً صريحاً وغير مختبر يُفعَّل عبر `mariadb_configure_repo: true`. ولا يُعدّ محدّد `mariadb_version` القديم إصدارَ خادمٍ أصلي ولا توصيةً بإصدار مدعوم من المصدر الأصلي. كما أن المرايا القديمة المرمّزة مسبقاً لا تغطي كل توزيعة حالية؛ لذا استخدم الخيار الأصلي الافتراضي أو تحقّق من صلاحية تهيئة المستودع بشكل مستقل أولاً.

يكتشف الدور إصدار الخادم قيد التشغيل ودليل البيانات الخاص به قبل كتابة التهيئة. ويحافظ ذلك على المسار `/var/lib/mariadb` في Ubuntu 26.04 وعلى تخزين قواعد البيانات القائم. ويفشل تعيين `mariadb_data_dir` متعارض صراحةً مع إظهار متطلب الترحيل؛ إذ لا ينقل الدور البيانات. وتظل التجاوزات العامة للحزم والخدمات والمقابس وملفات التهيئة متاحة.

تستخدم تغييرات كلمات المرور عبارات مُعلَّمة (parameterized statements) ليتمكّن MariaDB من تطبيق إضافة التحقق الصارم من كلمات المرور. ويستخدم ملف العميل الخاص بالمستخدم root مقبس Unix المحلي. بينما تحتفظ الحسابات غير المعدّلة بصلاحياتها وكلمات مرورها.

## التطوير والاختبار

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

تُعرَّف هذه الأهداف في [Makefile](../../../Makefile). ويتطلب Molecule مشغّله وتبعيات الاختبار الخاصة به. وتستخدم أهداف Docker الملفات الموجودة ضمن [dev](../../../dev)؛ والهدف الأساسي لـ Docker هو `make docker-test` وليس `make test-docker`.

## التوثيق والأمان والترخيص

- [أمثلة التهيئة](../../../docs/README.md)
- [المساهمة](../../../CONTRIBUTING.md)
- [سياسة الأمان](../../../SECURITY.md)
- [رخصة MIT](../../../LICENSE)
