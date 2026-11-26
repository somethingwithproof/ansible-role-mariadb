<!-- translations:start -->
**Languages:** [English](../../../README.md) · **isiXhosa** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · **isiXhosa** · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Indima ye-Ansible ye-MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Indima ye-Ansible yokufaka i-MariaDB, ukulungiselela iziseko zedatha nabasebenzisi, kunye nokuqwalasela imisebenzi ekhethwayo yokugcina iikopi zokhuseleko nokubeka iliso. Le ndima yahlula ukufakelwa, uqwalaselo, uqinisekiso, kunye nemisebenzi yokusebenza ukuze nganye iphononongwe ngokuzimeleyo.

## Izakhono

| Indawo | Ukumiselwa |
| --- | --- |
| Ukufakelwa noqwalaselo | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml), kunye neetemplate zoqwalaselo |
| Uqinisekiso lolwazi olungenisiweyo noseto lweeakhawunti | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Ukulungiselelwa kwesiseko sedatha | [databases.yml](../../../tasks/databases.yml) |
| Useto lophindaphindo | I-[replication.yml](../../../tasks/replication.yml) imisela ii-ID zomncedisi kunye noseto lwe-binary logging nomsebenzisi kwicala eliyintloko |
| Iikopi zokhuseleko ezicwangcisiweyo | [backup.yml](../../../tasks/backup.yml) kunye [netemplate yesikripthi sekopi yokhuseleko](../../../templates/mariadb_backup.sh.j2) |
| Ukubeka iliso | [monitoring.yml](../../../tasks/monitoring.yml) kunye neetemplate ze-exporter novavanyo |

Imisebenzi yophindaphindo efakiweyo ayiphumezi ukubuyela ngokuzenzekelayo xa kukho ukusilela okanye ukuqaliswa okupheleleyo kwe-replica. Iimeko ezininzi ze-Molecule yitopology yovavanyo, hayi ubungqina bokufakelwa kweemeko ezininzi kumncedisi omnye. Phonononga ufihlo lweekopi zokhuseleko, ukuziphatha kokubuyisela, kunye nokuhambelana kwenguqulelo yesiseko sedatha kufakelo lwakho; aziqinisekiswanga yile README.

## Faka uze usebenzise

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

Nikezela ngeziguquguquki zamagama okugqitha ekubhekiselwe kuzo nge-Ansible Vault okanye ngenkqubo yakho yolawulo lweemfihlo. Sebenzisa i-[defaults/main.yml](../../../defaults/main.yml) kumagama okwenene okukhetha kunye namaxabiso asisiseko.

## Iimfuno nokuhambelana

Isilawuli sangoku yi-Ansible 14.5.0 / ansible-core 2.21.5 ene-Python
3.13. Imeko ye-`lts` ivavanya iipakethe zemveli zenkqubo yokusasaza kwi-Ubuntu
22.04, 24.04 kunye ne-26.04, i-Debian 12 kunye ne-13, kunye ne-Rocky Linux 9 kunye ne-10. Amagama ezibizo e-EL
kwimetadata awamisi isiqinisekiso esahlukileyo se-RHEL okanye se-AlmaLinux.

Iipakethe zemveli zenkqubo yokusasaza zezisisiseko kwiqonga ngalinye elivavanyiweyo.
Iifayile ze-repository zangaphandle ezikhoyo azisuswa, kwaye indima ayifudusi
umncedisi ofakiweyo phakathi kwemithombo yeepakethe okanye iinguqulelo ezinkulu. Phonononga
iingxabano zomlawuli weepakethe phambi kokufudusa ufakelo lwangaphandle olukhoyo.

Indlela ye-repository yangaphandle lukhetho olucacileyo olungavavanywanga nge-`mariadb_configure_repo: true`.
Isikhethi sayo sakudala se-`mariadb_version` asiyiyo inguqulelo yomncedisi wemveli okanye
isindululo sokukhutshwa okuxhaswayo komthombo oyintloko.
Iimirror ezindala ezibhalwe ngqo kwikhowudi azigubungeli yonke inkqubo yokusasaza yangoku; sebenzisa
isiseko semveli okanye uqinisekise ngokuzimeleyo uqwalaselo lwe-repository kuqala.

Indima ifumanisa inguqulelo yomncedisi osebenzayo kunye nolawulo lwedatha phambi
kokubhala uqwalaselo. Oku kugcina i-`/var/lib/mariadb` ye-Ubuntu 26.04 kunye
nogcino lwesiseko sedatha olukhoyo. I-`mariadb_data_dir` ecacileyo engqubanayo iyasilela
ngemfuneko yemfuduko; indima ayiyihambisi idatha. Utshintsho lwesidlangalala lwepakethe,
inkonzo, isokethi kunye nefayile yoqwalaselo luhlala lufumaneka.

Utshintsho lwamagama okugqitha lusebenzisa izitatimende ezineeparameter ukuze i-MariaDB ikwazi ukunyanzelisa
iplagini yayo engqongqo yokuqinisekisa amagama okugqitha. Ifayile yabucala yomxhasi ka-root isebenzisa
isokethi ye-Unix yasekhaya. Iiakhawunti ezingatshintshwanga zigcina iimvume zazo namagama azo okugqitha.

## Uphuhliso novavanyo

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Ezi njongo zichazwe kwi-[Makefile](../../../Makefile). I-Molecule ifuna umqhubi wayo kunye nezinto ezixhomekeke kuzo zovavanyo. Iinjongo ze-Docker zisebenzisa iifayile phantsi kwe-[dev](../../../dev); i-`make docker-test` yinjongo esisiseko ye-Docker, hayi i-`make test-docker`.

## Amaxwebhu, ukhuseleko, nelayisenisi

- [Imizekelo yoqwalaselo](../../../docs/README.md)
- [Ukufaka isandla](../../../CONTRIBUTING.md)
- [Umgaqo-nkqubo wokhuseleko](../../../SECURITY.md)
- [Ilayisenisi ye-MIT](../../../LICENSE)
