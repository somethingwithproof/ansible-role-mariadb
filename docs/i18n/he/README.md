<!-- translations:start -->
**Languages:** [English](../../../README.md) · **עברית** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · **עברית** · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# תפקיד Ansible עבור MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

תפקיד Ansible להתקנת MariaDB, הקצאת מסדי נתונים ומשתמשים, והגדרת משימות גיבוי וניטור אופציונליות. התפקיד מפריד בין משימות ההתקנה, התצורה, האימות והתפעול כך שניתן יהיה לסקור כל אחת מהן בנפרד.

## יכולות

| תחום | מימוש |
| --- | --- |
| התקנה ותצורה | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml) ותבניות תצורה |
| אימות קלט והגדרת חשבונות | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| הקצאת מסדי נתונים | [databases.yml](../../../tasks/databases.yml) |
| הגדרות שכפול (Replication) | [replication.yml](../../../tasks/replication.yml) מגדיר מזהי שרת והגדרות יומן בינארי/משתמש בצד הראשי |
| גיבויים מתוזמנים | [backup.yml](../../../tasks/backup.yml) ו[תבנית סקריפט הגיבוי](../../../templates/mariadb_backup.sh.j2) |
| ניטור | [monitoring.yml](../../../tasks/monitoring.yml) ותבניות exporter ובדיקות |

משימות השכפול השמורות במאגר אינן מממשות מעבר אוטומטי לגיבוי (failover) או אתחול מלא של עותק משני (replica). מספר מופעי Molecule מהווים טופולוגיית בדיקה, ולא הוכחה לפריסת ריבוי מופעים על מארח יחיד. בדקו את הצפנת הגיבויים, התנהגות השחזור ותאימות גרסת מסד הנתונים עבור הפריסה שלכם; אלה אינם מובטחים על ידי קובץ README זה.

## התקנה ושימוש

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

ספקו את משתני הסיסמאות הנדרשים באמצעות Ansible Vault או מערכת ניהול הסודות שלכם. היעזרו ב-[defaults/main.yml](../../../defaults/main.yml) עבור שמות האפשרויות וערכי ברירת המחדל בפועל.

## דרישות ותאימות

הבקר הנוכחי הוא Ansible 14.5.0 / ansible-core 2.21.5 עם Python 3.13. התרחיש `lts` בוחן חבילות הפצה מקוריות על Ubuntu 22.04, 24.04 ו-26.04, על Debian 12 ו-13, ועל Rocky Linux 9 ו-10. כינויי EL במטא-דאטה אינם מהווים הסמכה נפרדת ל-RHEL או ל-AlmaLinux.

חבילות ההפצה המקוריות הן ברירת המחדל בכל פלטפורמה שנבדקה. קובצי מאגרים חיצוניים קיימים אינם מוסרים, והתפקיד אינו מבצע הגירה של שרת מותקן בין מקורות חבילות או גרסאות ראשיות. בדקו התנגשויות במנהל החבילות לפני הגירה של התקנה חיצונית קיימת.

נתיב המאגר החיצוני הוא בחירה מפורשת שאינה נבדקת, המופעלת באמצעות `mariadb_configure_repo: true`. בורר ה-`mariadb_version` הישן אינו מציין גרסת שרת מקורית ואינו המלצה למהדורת upstream נתמכת. שרתי המראה הישנים המקודדים קשיח אינם מכסים כל הפצה עדכנית; השתמשו בברירת המחדל המקורית או בצעו תחילה אימות עצמאי של תצורת המאגר.

התפקיד מזהה את גרסת השרת הפועל ואת תיקיית הנתונים שלו לפני כתיבת התצורה. כך נשמרים הנתיב `/var/lib/mariadb` ב-Ubuntu 26.04 ואחסון מסד הנתונים הקיים. הגדרה מפורשת סותרת של `mariadb_data_dir` נכשלת עם דרישת הגירה; התפקיד אינו מעביר נתונים. דריסות ציבוריות עבור חבילות, שירות, socket וקובצי תצורה נשארות זמינות.

שינויי סיסמאות משתמשים במשפטים פרמטריים כדי ש-MariaDB יוכל לאכוף את תוסף אימות הסיסמאות הקפדני שלו. קובץ הלקוח הפרטי של root משתמש ב-Unix socket המקומי. חשבונות שלא שונו שומרים על ההרשאות והסיסמאות שלהם.

## פיתוח ובדיקות

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

יעדים אלה מוגדרים ב-[Makefile](../../../Makefile). Molecule דורש את מנהל ההתקן (driver) ותלויות הבדיקה שלו. יעדי Docker משתמשים בקבצים תחת [dev](../../../dev); `make docker-test` הוא יעד ה-Docker הבסיסי, ולא `make test-docker`.

## תיעוד, אבטחה ורישיון

- [דוגמאות תצורה](../../../docs/README.md)
- [תרומה לפרויקט](../../../CONTRIBUTING.md)
- [מדיניות אבטחה](../../../SECURITY.md)
- [רישיון MIT](../../../LICENSE)
