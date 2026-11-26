<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Kiswahili** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · **Kiswahili** · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Role ya Ansible ya MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Role ya Ansible ya kusakinisha MariaDB, kuandaa hifadhidata na watumiaji, na kusanidi kazi za hiari za nakala rudufu na ufuatiliaji. Role hii hutenganisha kazi za usakinishaji, usanidi, uthibitishaji, na uendeshaji ili kila moja iweze kukaguliwa kando.

## Uwezo

| Eneo | Utekelezaji |
| --- | --- |
| Usakinishaji na usanidi | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml), na violezo vya usanidi |
| Uthibitishaji wa data za ingizo na usanidi wa akaunti | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Uandaaji wa hifadhidata | [databases.yml](../../../tasks/databases.yml) |
| Mipangilio ya urudufishaji (replication) | [replication.yml](../../../tasks/replication.yml) huweka vitambulisho vya seva na mipangilio ya binary logging/watumiaji upande wa seva kuu |
| Nakala rudufu za ratiba | [backup.yml](../../../tasks/backup.yml) na [kiolezo cha hati ya nakala rudufu](../../../templates/mariadb_backup.sh.j2) |
| Ufuatiliaji | [monitoring.yml](../../../tasks/monitoring.yml) na violezo vya exporter/ukaguzi |

Kazi za urudufishaji zilizomo hazitekelezi uhamishaji wa kiotomatiki wakati wa hitilafu wala uanzishaji kamili wa nakala (replica). Mifano mingi ya Molecule ni topolojia ya majaribio, si ushahidi wa utekelezaji wa mifano mingi kwenye mashine moja. Kagua usimbaji fiche wa nakala rudufu, tabia ya urejeshaji, na uoanifu wa toleo la hifadhidata kwa mazingira yako; hayo hayadhaminiwi na README hii.

## Usakinishaji na matumizi

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

Weka vigeu vya nenosiri vilivyorejelewa kupitia Ansible Vault au mfumo wako wa usimamizi wa siri. Tumia [defaults/main.yml](../../../defaults/main.yml) kwa majina halisi ya chaguo na mipangilio ya awali.

## Mahitaji na uoanifu

Kidhibiti cha sasa ni Ansible 14.5.0 / ansible-core 2.21.5 na Python 3.13. Tukio la `lts` hujaribu vifurushi asili vya mfumo kwenye Ubuntu 22.04, 24.04 na 26.04, Debian 12 na 13, na Rocky Linux 9 na 10. Majina mengine ya EL katika metadata hayathibitishi cheti tofauti cha RHEL au AlmaLinux.

Vifurushi asili vya mfumo ndivyo chaguo-msingi kwenye kila jukwaa lililojaribiwa. Faili zilizopo za hazina za nje haziondolewi, na role hii haihamishi seva iliyosakinishwa kati ya vyanzo vya vifurushi au matoleo makuu. Kagua migongano ya kidhibiti cha vifurushi kabla ya kuhamisha usakinishaji wa nje uliopo.

Njia ya hazina ya nje ni chaguo la wazi ambalo halijajaribiwa kupitia `mariadb_configure_repo: true`. Kiteuzi chake cha zamani cha `mariadb_version` si toleo la seva asili wala pendekezo la toleo la chanzo kikuu linalotumika. Vioo vya zamani vilivyoandikwa moja kwa moja havishughulikii kila toleo la sasa la mfumo; tumia chaguo-msingi asili au thibitisha usanidi wa hazina kando kwanza.

Role hugundua toleo la seva inayoendesha na saraka yake ya data kabla ya kuandika usanidi. Hii huhifadhi `/var/lib/mariadb` ya Ubuntu 26.04 na hifadhi ya hifadhidata iliyopo. `mariadb_data_dir` iliyobainishwa wazi inayokinzana hushindwa na kuhitaji uhamishaji; role haihamishi data. Mabadiliko ya umma ya vifurushi, huduma, soketi na faili za usanidi hubaki yanapatikana.

Mabadiliko ya nenosiri hutumia kauli zenye vigezo (parameterized statements) ili MariaDB iweze kutekeleza programu-jalizi yake kali ya uthibitishaji wa nenosiri. Faili ya faragha ya mteja ya root hutumia soketi ya ndani ya Unix. Akaunti ambazo hazijabadilishwa huhifadhi ruhusa na manenosiri yake.

## Uendelezaji na majaribio

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Malengo haya yamefafanuliwa katika [Makefile](../../../Makefile). Molecule inahitaji dereva wake na vitegemezi vya majaribio. Malengo ya Docker hutumia faili zilizo chini ya [dev](../../../dev); `make docker-test` ndilo lengo la msingi la Docker, si `make test-docker`.

## Nyaraka, usalama, na leseni

- [Mifano ya usanidi](../../../docs/README.md)
- [Kuchangia](../../../CONTRIBUTING.md)
- [Sera ya usalama](../../../SECURITY.md)
- [Leseni ya MIT](../../../LICENSE)
