<!-- translations:start -->
**Languages:** [English](../../../README.md) · **አማርኛ** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · **አማርኛ** · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# የMariaDB Ansible ሚና

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

MariaDBን ለመጫን፣ የውሂብ ጎታዎችን እና ተጠቃሚዎችን ለማዘጋጀት እንዲሁም አማራጭ የመጠባበቂያ ቅጂ እና የክትትል ተግባራትን ለማዋቀር የሚያገለግል የAnsible ሚና። ሚናው የመጫን፣ የማዋቀር፣ የማረጋገጥ እና የአሠራር ተግባራትን ስለሚለይ እያንዳንዱ በተናጠል ሊገመገም ይችላል።

## ችሎታዎች

| ዘርፍ | አተገባበር |
| --- | --- |
| መጫን እና ማዋቀር | [install.yml](../../../tasks/install.yml)፣ [configure.yml](../../../tasks/configure.yml) እና የውቅር አብነቶች |
| የግቤት ማረጋገጫ እና የመለያ ማዋቀር | [validate.yml](../../../tasks/validate.yml)፣ [secure.yml](../../../tasks/secure.yml)፣ [users.yml](../../../tasks/users.yml) |
| የውሂብ ጎታ ማዘጋጀት | [databases.yml](../../../tasks/databases.yml) |
| የማባዛት ቅንብሮች | [replication.yml](../../../tasks/replication.yml) የአገልጋይ መለያዎችን እና የዋናው ወገን ሁለትዮሽ ምዝግብ/ተጠቃሚ ቅንብሮችን ያዘጋጃል |
| የታቀዱ መጠባበቂያ ቅጂዎች | [backup.yml](../../../tasks/backup.yml) እና [የመጠባበቂያ ቅጂ ስክሪፕት አብነት](../../../templates/mariadb_backup.sh.j2) |
| ክትትል | [monitoring.yml](../../../tasks/monitoring.yml) እና የላኪ/ፍተሻ አብነቶች |

በማከማቻው ውስጥ የተካተቱት የማባዛት ተግባራት ራስ-ሰር መተካካትን ወይም ሙሉ የቅጂ ማስጀመርን ተግባራዊ አያደርጉም። በርካታ የMolecule አሃዶች የሙከራ ቶፖሎጂ እንጂ በአንድ አስተናጋጅ ላይ ባለብዙ-አሃድ ማሰማራት ማስረጃ አይደሉም። ለማሰማራትዎ የመጠባበቂያ ቅጂ ምስጠራን፣ የመልሶ ማግኛ ባህሪን እና የውሂብ ጎታ ሥሪት ተኳሃኝነትን ይገምግሙ፤ በዚህ README ዋስትና አይሰጣቸውም።

## መጫን እና መጠቀም

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

የተጠቀሱትን የይለፍ ቃል ተለዋዋጮች በAnsible Vault ወይም በምስጢር አስተዳደር ሥርዓትዎ በኩል ያቅርቡ። ለትክክለኛዎቹ የአማራጭ ስሞች እና ነባሪዎች [defaults/main.yml](../../../defaults/main.yml)ን ይጠቀሙ።

## መስፈርቶች እና ተኳሃኝነት

የአሁኑ ተቆጣጣሪ Ansible 14.5.0 / ansible-core 2.21.5 ከPython 3.13 ጋር ነው። የ`lts` ሁኔታ በUbuntu 22.04፣ 24.04 እና 26.04፣ Debian 12 እና 13፣ እንዲሁም Rocky Linux 9 እና 10 ላይ ነባር የሥርጭት ጥቅሎችን ይፈትሻል። በሜታዳታ ውስጥ ያሉ የEL ተለዋጭ ስሞች የተለየ የRHEL ወይም የAlmaLinux የምስክር ወረቀት አያረጋግጡም።

ነባር የሥርጭት ጥቅሎች በእያንዳንዱ የተፈተሸ መድረክ ላይ ነባሪ ናቸው። ነባር ውጫዊ የማከማቻ ፋይሎች አይወገዱም፣ እንዲሁም ሚናው የተጫነ አገልጋይን በጥቅል ምንጮች ወይም በዋና ሥሪቶች መካከል አያዛውርም። ነባር ውጫዊ ጭነትን ከማዛወርዎ በፊት የጥቅል አስተዳዳሪ ግጭቶችን ይገምግሙ።

ውጫዊው የማከማቻ መንገድ በ`mariadb_configure_repo: true` በኩል በግልጽ የሚመረጥ ያልተፈተሸ አማራጭ ነው። የቀድሞው `mariadb_version` መራጭ ነባር የአገልጋይ ሥሪት ወይም ለሚደገፍ የዋና ምንጭ ልቀት የተሰጠ ምክረ ሐሳብ አይደለም። የቆዩት በቋሚነት የተጻፉ መስታወቶች እያንዳንዱን የአሁኑን ሥርጭት አይሸፍኑም፤ ነባሪውን የሥርጭት ጥቅል ይጠቀሙ ወይም በመጀመሪያ የማከማቻ ውቅሩን በተናጠል ያረጋግጡ።

ሚናው ውቅር ከመጻፉ በፊት እየሠራ ያለውን አገልጋይ ሥሪት እና የውሂብ ማውጫ ይለያል። ይህ የUbuntu 26.04ን `/var/lib/mariadb` እና ነባሩን የውሂብ ጎታ ማከማቻ ይጠብቃል። በግልጽ የሚጋጭ `mariadb_data_dir` የማዛወር መስፈርት በማሳየት ይከሽፋል፤ ሚናው ውሂብ አያዛውርም። ይፋዊ የጥቅል፣ የአገልግሎት፣ የሶኬት እና የውቅር ፋይል ተለዋጮች እንደተጠበቁ ይገኛሉ።

MariaDB ጥብቅ የይለፍ ቃል ማረጋገጫ ተሰኪውን ተግባራዊ እንዲያደርግ የይለፍ ቃል ለውጦች በመለኪያ የተዋቀሩ መግለጫዎችን ይጠቀማሉ። የroot የግል ደንበኛ ፋይል የአካባቢውን Unix ሶኬት ይጠቀማል። ያልተለወጡ መለያዎች ፈቃዶቻቸውን እና የይለፍ ቃሎቻቸውን ይይዛሉ።

## ልማት እና ሙከራ

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

እነዚህ ዒላማዎች በ[Makefile](../../../Makefile) ውስጥ ተገልጸዋል። Molecule ሾፌሩን እና የሙከራ ጥገኞቹን ይፈልጋል። የDocker ዒላማዎች በ[dev](../../../dev) ሥር ያሉ ፋይሎችን ይጠቀማሉ፤ መሠረታዊው የDocker ዒላማ `make docker-test` እንጂ `make test-docker` አይደለም።

## ሰነዶች፣ ደህንነት እና ፈቃድ

- [የውቅር ምሳሌዎች](../../../docs/README.md)
- [አስተዋጽኦ ማበርከት](../../../CONTRIBUTING.md)
- [የደህንነት ፖሊሲ](../../../SECURITY.md)
- [የMIT ፈቃድ](../../../LICENSE)
