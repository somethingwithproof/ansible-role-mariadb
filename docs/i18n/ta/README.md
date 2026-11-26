<!-- translations:start -->
**Languages:** [English](../../../README.md) · **தமிழ்** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · **தமிழ்** · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# MariaDB Ansible பாத்திரம்

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

MariaDB-ஐ நிறுவவும், தரவுத்தளங்கள் மற்றும் பயனர்களை அமைக்கவும், விருப்பக் காப்புப்பிரதி மற்றும் கண்காணிப்புப் பணிகளைக் கட்டமைக்கவும் உதவும் ஒரு Ansible பாத்திரம். நிறுவல், கட்டமைப்பு, சரிபார்ப்பு மற்றும் செயல்பாட்டுப் பணிகளை ஒவ்வொன்றும் தனித்தனியாக மதிப்பாய்வு செய்யக்கூடிய வகையில் இந்தப் பாத்திரம் பிரித்து வைக்கிறது.

## திறன்கள்

| பகுதி | செயல்படுத்தல் |
| --- | --- |
| நிறுவல் மற்றும் கட்டமைப்பு | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml), மற்றும் கட்டமைப்பு வார்ப்புருக்கள் |
| உள்ளீட்டுச் சரிபார்ப்பு மற்றும் கணக்கு அமைப்பு | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| தரவுத்தள ஏற்பாடு | [databases.yml](../../../tasks/databases.yml) |
| நகலாக்க அமைப்புகள் | [replication.yml](../../../tasks/replication.yml) சேவையக ID-களையும் முதன்மைப் பக்க இருமப் பதிவு (binary logging)/பயனர் அமைப்புகளையும் அமைக்கிறது |
| திட்டமிடப்பட்ட காப்புப்பிரதிகள் | [backup.yml](../../../tasks/backup.yml) மற்றும் [காப்புப்பிரதி ஸ்கிரிப்ட் வார்ப்புரு](../../../templates/mariadb_backup.sh.j2) |
| கண்காணிப்பு | [monitoring.yml](../../../tasks/monitoring.yml) மற்றும் ஏற்றுமதியாளர்/சரிபார்ப்பு வார்ப்புருக்கள் |

இதில் உள்ள நகலாக்கப் பணிகள் தானியங்கி தோல்வி மாற்றத்தையோ (failover) அல்லது முழுமையான பிரதி (replica) துவக்கத்தையோ செயல்படுத்தாது. பல Molecule நிகழ்வுகள் ஒரு சோதனை அமைப்பாகும், ஒரே ஹோஸ்டில் பல நிகழ்வுகளை வரிசைப்படுத்துவதற்கான சான்று அல்ல. உங்கள் வரிசைப்படுத்தலுக்கான காப்புப்பிரதி குறியாக்கம், மீட்டெடுப்பு நடத்தை மற்றும் தரவுத்தளப் பதிப்பு இணக்கத்தன்மையை மதிப்பாய்வு செய்யவும்; இவை இந்த README-ஆல் உத்தரவாதம் அளிக்கப்படவில்லை.

## நிறுவல் மற்றும் பயன்பாடு

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

குறிப்பிடப்பட்டுள்ள கடவுச்சொல் மாறிகளை Ansible Vault அல்லது உங்கள் இரகசிய-மேலாண்மை அமைப்பு மூலம் வழங்கவும். உண்மையான விருப்பப் பெயர்களுக்கும் இயல்புநிலைகளுக்கும் [defaults/main.yml](../../../defaults/main.yml)-ஐப் பார்க்கவும்.

## தேவைகள் மற்றும் இணக்கத்தன்மை

தற்போதைய கட்டுப்படுத்தி Python 3.13 உடன் கூடிய Ansible 14.5.0 / ansible-core 2.21.5 ஆகும். `lts` சூழ்நிலை Ubuntu 22.04, 24.04 மற்றும் 26.04, Debian 12 மற்றும் 13, மற்றும் Rocky Linux 9 மற்றும் 10 ஆகியவற்றில் இயல்பான விநியோகத் தொகுப்புகளைச் சோதிக்கிறது. மெட்டாடேட்டாவில் உள்ள EL மாற்றுப்பெயர்கள் தனித்தனி RHEL அல்லது AlmaLinux சான்றிதழை உறுதிப்படுத்தாது.

சோதிக்கப்பட்ட ஒவ்வொரு தளத்திலும் இயல்பான விநியோகத் தொகுப்புகளே இயல்புநிலையாக உள்ளன. தற்போதுள்ள வெளிப்புறக் களஞ்சியக் கோப்புகள் அகற்றப்படாது, மேலும் இந்தப் பாத்திரம் நிறுவப்பட்ட சேவையகத்தைத் தொகுப்பு மூலங்களுக்கு இடையிலோ அல்லது முக்கிய பதிப்புகளுக்கு இடையிலோ இடம்பெயர்க்காது. தற்போதுள்ள வெளிப்புற நிறுவலை இடம்பெயர்ப்பதற்கு முன் தொகுப்பு-மேலாளர் முரண்பாடுகளை மதிப்பாய்வு செய்யவும்.

வெளிப்புறக் களஞ்சியப் பாதை என்பது `mariadb_configure_repo: true` வழியாக வெளிப்படையாகத் தேர்ந்தெடுக்கப்படும், சோதிக்கப்படாத விருப்பமாகும். இதன் பழைய `mariadb_version` தேர்வி ஒரு இயல்பான-சேவையகப் பதிப்போ அல்லது ஆதரிக்கப்படும் மேல்நிலை வெளியீட்டிற்கான பரிந்துரையோ அல்ல. பழைய நிலை-குறியிடப்பட்ட கண்ணாடிகள் (mirrors) தற்போதைய அனைத்து விநியோகங்களையும் உள்ளடக்காது; இயல்பான இயல்புநிலையைப் பயன்படுத்தவும் அல்லது முதலில் களஞ்சியக் கட்டமைப்பைத் தனிப்பட்ட முறையில் சரிபார்க்கவும்.

கட்டமைப்பை எழுதுவதற்கு முன்பு, இயங்கும் சேவையகத்தின் பதிப்பையும் தரவுக் கோப்புறையையும் இந்தப் பாத்திரம் கண்டறிகிறது. இது Ubuntu 26.04-இன் `/var/lib/mariadb` மற்றும் தற்போதுள்ள தரவுத்தளச் சேமிப்பகத்தைப் பாதுகாக்கிறது. வெளிப்படையான முரண்படும் `mariadb_data_dir` இடம்பெயர்வுத் தேவையுடன் தோல்வியடையும்; இந்தப் பாத்திரம் தரவை நகர்த்தாது. பொது தொகுப்பு, சேவை, சாக்கெட் மற்றும் கட்டமைப்பு-கோப்பு மேலெழுதல்கள் தொடர்ந்து கிடைக்கும்.

MariaDB தனது கடுமையான கடவுச்சொல்-சரிபார்ப்பு செருகுநிரலை அமல்படுத்தும் வகையில், கடவுச்சொல் மாற்றங்கள் அளவுருவாக்கப்பட்ட (parameterized) கூற்றுகளைப் பயன்படுத்துகின்றன. Root-இன் தனிப்பட்ட கிளையன்ட் கோப்பு உள்ளூர் Unix சாக்கெட்டைப் பயன்படுத்துகிறது. மாற்றப்படாத கணக்குகள் தங்கள் அனுமதிகளையும் கடவுச்சொற்களையும் தக்கவைத்துக் கொள்கின்றன.

## மேம்பாடு மற்றும் சோதனை

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

இந்த இலக்குகள் [Makefile](../../../Makefile)-இல் வரையறுக்கப்பட்டுள்ளன. Molecule-க்கு அதன் இயக்கி மற்றும் சோதனைச் சார்புகள் தேவை. Docker இலக்குகள் [dev](../../../dev)-இன் கீழ் உள்ள கோப்புகளைப் பயன்படுத்துகின்றன; அடிப்படை Docker இலக்கு `make docker-test` ஆகும், `make test-docker` அல்ல.

## ஆவணங்கள், பாதுகாப்பு மற்றும் உரிமம்

- [கட்டமைப்பு எடுத்துக்காட்டுகள்](../../../docs/README.md)
- [பங்களித்தல்](../../../CONTRIBUTING.md)
- [பாதுகாப்புக் கொள்கை](../../../SECURITY.md)
- [MIT உரிமம்](../../../LICENSE)
