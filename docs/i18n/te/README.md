<!-- translations:start -->
**Languages:** [English](../../../README.md) · **తెలుగు** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · **తెలుగు** · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# MariaDB Ansible రోల్

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

MariaDBను ఇన్‌స్టాల్ చేయడానికి, డేటాబేస్‌లు మరియు యూజర్లను ప్రొవిజన్ చేయడానికి, అలాగే ఐచ్ఛిక బ్యాకప్ మరియు మానిటరింగ్ టాస్క్‌లను కాన్ఫిగర్ చేయడానికి ఉపయోగపడే Ansible రోల్. ప్రతిదాన్ని స్వతంత్రంగా సమీక్షించగలిగేలా ఈ రోల్ ఇన్‌స్టాలేషన్, కాన్ఫిగరేషన్, ధృవీకరణ మరియు ఆపరేషనల్ టాస్క్‌లను వేరుగా ఉంచుతుంది.

## సామర్థ్యాలు

| విభాగం | అమలు |
| --- | --- |
| ఇన్‌స్టాలేషన్ మరియు కాన్ఫిగరేషన్ | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml), మరియు కాన్ఫిగరేషన్ టెంప్లేట్‌లు |
| ఇన్‌పుట్ ధృవీకరణ మరియు ఖాతా సెటప్ | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| డేటాబేస్ ప్రొవిజనింగ్ | [databases.yml](../../../tasks/databases.yml) |
| రెప్లికేషన్ సెట్టింగ్‌లు | [replication.yml](../../../tasks/replication.yml) సర్వర్ IDలు మరియు ప్రైమరీ-సైడ్ బైనరీ లాగింగ్/యూజర్ సెట్టింగ్‌లను సెట్ చేస్తుంది |
| షెడ్యూల్ చేసిన బ్యాకప్‌లు | [backup.yml](../../../tasks/backup.yml) మరియు [బ్యాకప్ స్క్రిప్ట్ టెంప్లేట్](../../../templates/mariadb_backup.sh.j2) |
| మానిటరింగ్ | [monitoring.yml](../../../tasks/monitoring.yml) మరియు ఎక్స్‌పోర్టర్/చెక్ టెంప్లేట్‌లు |

చెక్-ఇన్ చేయబడిన రెప్లికేషన్ టాస్క్‌లు ఆటోమేటెడ్ ఫెయిల్‌ఓవర్ లేదా పూర్తి రెప్లికా ఇనిషియలైజేషన్‌ను అమలు చేయవు. బహుళ Molecule ఇన్‌స్టాన్స్‌లు అనేవి ఒక టెస్ట్ టోపాలజీ మాత్రమే, ఒకే హోస్ట్‌లో మల్టీ-ఇన్‌స్టాన్స్ డిప్లాయ్‌మెంట్‌కు ఆధారం కాదు. మీ డిప్లాయ్‌మెంట్ కోసం బ్యాకప్ ఎన్‌క్రిప్షన్, రిస్టోర్ ప్రవర్తన మరియు డేటాబేస్-వెర్షన్ అనుకూలతను సమీక్షించండి; ఈ README వాటికి హామీ ఇవ్వదు.

## ఇన్‌స్టాల్ మరియు వినియోగం

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

ప్రస్తావించిన పాస్‌వర్డ్ వేరియబుల్స్‌ను Ansible Vault లేదా మీ సీక్రెట్-మేనేజ్‌మెంట్ సిస్టమ్ ద్వారా అందించండి. అసలు ఆప్షన్ పేర్లు మరియు డిఫాల్ట్‌ల కోసం [defaults/main.yml](../../../defaults/main.yml)ను ఉపయోగించండి.

## అవసరాలు మరియు అనుకూలత

ప్రస్తుత కంట్రోలర్ Python 3.13తో Ansible 14.5.0 / ansible-core 2.21.5.
`lts` సినారియో Ubuntu 22.04, 24.04 మరియు 26.04, Debian 12 మరియు 13, మరియు Rocky Linux 9 మరియు 10లో
నేటివ్ డిస్ట్రిబ్యూషన్ ప్యాకేజీలను పరీక్షిస్తుంది. మెటాడేటాలోని EL అలియాస్‌లు ప్రత్యేక RHEL లేదా
AlmaLinux సర్టిఫికేషన్‌ను నిర్ధారించవు.

పరీక్షించబడిన ప్రతి ప్లాట్‌ఫారమ్‌లో నేటివ్ డిస్ట్రిబ్యూషన్ ప్యాకేజీలు డిఫాల్ట్‌గా ఉంటాయి.
ఇప్పటికే ఉన్న బాహ్య రిపోజిటరీ ఫైళ్లు తొలగించబడవు, మరియు ఈ రోల్ ఇన్‌స్టాల్ చేయబడిన సర్వర్‌ను
ప్యాకేజీ మూలాలు లేదా ప్రధాన వెర్షన్ల మధ్య మైగ్రేట్ చేయదు. ఇప్పటికే ఉన్న బాహ్య ఇన్‌స్టాలేషన్‌ను
మైగ్రేట్ చేసే ముందు ప్యాకేజీ-మేనేజర్ వైరుధ్యాలను సమీక్షించండి.

బాహ్య రిపోజిటరీ మార్గం అనేది `mariadb_configure_repo: true` ద్వారా స్పష్టంగా ఎంచుకోవాల్సిన,
పరీక్షించబడని ఆప్ట్-ఇన్. దాని పాత `mariadb_version` సెలెక్టర్ నేటివ్-సర్వర్ వెర్షన్ కాదు లేదా
మద్దతు ఉన్న అప్‌స్ట్రీమ్ రిలీజ్ కోసం సిఫార్సు కాదు. పాత హార్డ్-కోడెడ్ మిర్రర్లు ప్రస్తుత ప్రతి
డిస్ట్రిబ్యూషన్‌ను కవర్ చేయవు; నేటివ్ డిఫాల్ట్‌ను ఉపయోగించండి లేదా ముందుగా రిపోజిటరీ
కాన్ఫిగరేషన్‌ను స్వతంత్రంగా ధృవీకరించండి.

కాన్ఫిగరేషన్ రాయడానికి ముందే ఈ రోల్ నడుస్తున్న సర్వర్ యొక్క వెర్షన్ మరియు డేటా డైరెక్టరీని
గుర్తిస్తుంది. ఇది Ubuntu 26.04 యొక్క `/var/lib/mariadb` మరియు ఇప్పటికే ఉన్న డేటాబేస్
స్టోరేజ్‌ను సంరక్షిస్తుంది. స్పష్టమైన విరుద్ధ `mariadb_data_dir` మైగ్రేషన్ అవసరంతో
విఫలమవుతుంది; ఈ రోల్ డేటాను తరలించదు. పబ్లిక్ ప్యాకేజీ, సర్వీస్, సాకెట్ మరియు
కాన్ఫిగరేషన్-ఫైల్ ఓవర్‌రైడ్‌లు అందుబాటులో ఉంటాయి.

MariaDB తన కఠినమైన పాస్‌వర్డ్-ధృవీకరణ ప్లగిన్‌ను అమలు చేయడానికి వీలుగా పాస్‌వర్డ్ మార్పులు
పారామీటరైజ్డ్ స్టేట్‌మెంట్‌లను ఉపయోగిస్తాయి. Root యొక్క ప్రైవేట్ క్లయింట్ ఫైల్ లోకల్ Unix
సాకెట్‌ను ఉపయోగిస్తుంది. మార్పు చేయని ఖాతాలు తమ గ్రాంట్‌లు మరియు పాస్‌వర్డ్‌లను నిలుపుకుంటాయి.

## అభివృద్ధి మరియు పరీక్ష

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

ఈ టార్గెట్‌లు [Makefile](../../../Makefile)లో నిర్వచించబడ్డాయి. Moleculeకు దాని డ్రైవర్ మరియు టెస్ట్ డిపెండెన్సీలు అవసరం. Docker టార్గెట్‌లు [dev](../../../dev) క్రింద ఉన్న ఫైళ్లను ఉపయోగిస్తాయి; ప్రాథమిక Docker టార్గెట్ `make docker-test`, `make test-docker` కాదు.

## డాక్యుమెంటేషన్, భద్రత మరియు లైసెన్స్

- [కాన్ఫిగరేషన్ ఉదాహరణలు](../../../docs/README.md)
- [సహకారం](../../../CONTRIBUTING.md)
- [భద్రతా విధానం](../../../SECURITY.md)
- [MIT లైసెన్స్](../../../LICENSE)
