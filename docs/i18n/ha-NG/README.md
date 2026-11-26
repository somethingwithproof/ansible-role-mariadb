<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Hausa** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · **Hausa** · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Aikin Ansible na MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Aikin Ansible ne don girka MariaDB, samar da rumbunan adana bayanai da masu amfani, da kuma saita ayyukan ajiyar baya da sa ido na zaɓi. Aikin yana raba girkawa, saitawa, tantancewa, da ayyukan gudanarwa don a iya duba kowannensu daban.

## Ƙarfin aiki

| Fanni | Aiwatarwa |
| --- | --- |
| Girkawa da saitawa | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml), da samfuran saiti |
| Tantance shigarwa da saita asusu | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Samar da rumbun adana bayanai | [databases.yml](../../../tasks/databases.yml) |
| Saitunan kwafi (replication) | [replication.yml](../../../tasks/replication.yml) yana saita lambobin ID na uwar garke da saitunan rajistar binary/mai amfani na babban ɓangare |
| Ajiyar baya mai tsari | [backup.yml](../../../tasks/backup.yml) da [samfurin rubutun ajiyar baya](../../../templates/mariadb_backup.sh.j2) |
| Sa ido | [monitoring.yml](../../../tasks/monitoring.yml) da samfuran fitar da bayanai/bincike |

Ayyukan kwafi (replication) da ke cikin ma'ajiyar ba sa aiwatar da sauyawa ta atomatik yayin gazawa (failover) ko cikakken fara aikin kwafi (replica). Kasancewar samfuran Molecule da yawa tsarin gwaji ne kawai, ba shaidar tura samfura da yawa a kan na'ura ɗaya ba. Duba ɓoyayyen tsaron ajiyar baya (encryption), halayyar maidowa, da dacewar sigar rumbun adana bayanai don turawarka; wannan README bai ba da garantin su ba.

## Girkawa da amfani

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

Samar da masu canjin kalmar sirri da aka ambata ta hanyar Ansible Vault ko tsarin sarrafa sirrinka. Yi amfani da [defaults/main.yml](../../../defaults/main.yml) don ainihin sunayen zaɓuka da saitunan tsoho.

## Buƙatu da dacewa

Mai sarrafawa (controller) na yanzu shi ne Ansible 14.5.0 / ansible-core 2.21.5 tare da Python
3.13. Yanayin gwajin `lts` yana gwada fakitin rarrabawa na asali a kan Ubuntu
22.04, 24.04 da 26.04, Debian 12 da 13, da kuma Rocky Linux 9 da 10. Sunayen madadin EL
a cikin metadata ba sa tabbatar da takardar shaidar RHEL ko AlmaLinux daban.

Fakitin rarrabawa na asali su ne tsoho a kan kowane dandamali da aka gwada.
Ba a cire fayilolin ma'ajiyar waje da ke akwai, kuma aikin ba ya
ƙaura da uwar garken da aka girka tsakanin tushen fakiti ko manyan sigogi. Duba
rikice-rikicen manajan fakiti kafin ƙaura da tsohon girkawa na waje.

Hanyar ma'ajiyar waje zaɓi ne na musamman wanda ba a gwada ba ta hanyar
`mariadb_configure_repo: true`. Tsohon mai zaɓin `mariadb_version` nasa ba
sigar uwar garke ta asali ba ce ko shawarar sakin tushe da ake goyon baya.
Tsofaffin madubai da aka rubuta kai tsaye ba sa rufe kowane nau'in tsarin aiki na yanzu; yi amfani da
tsohon tsari na asali ko ka fara tantance saitin ma'ajiyar da kanka.

Aikin yana gano sigar uwar garken da ke gudana da kundin bayanai kafin
rubuta saiti. Wannan yana kiyaye `/var/lib/mariadb` na Ubuntu 26.04 da
ajiyar rumbun adana bayanai da ke akwai. Sanya `mariadb_data_dir` da ya ci karo a fili yana kasawa
tare da buƙatar ƙaura; aikin ba ya matsar da bayanai. Canje-canjen fakiti na jama'a,
sabis, socket da fayilolin saiti suna nan a buɗe don amfani.

Canje-canjen kalmar sirri suna amfani da umarnin da aka sanya ma'auni (parameterized statements) don MariaDB ya iya aiwatar da
ƙarin manhajar tantance kalmar sirri mai tsauri. Fayil ɗin abokin ciniki na sirri na Root yana amfani da
Unix socket na gida. Asusun da ba a canza ba suna riƙe da izini da kalmomin sirrinsu.

## Haɓakawa da gwaji

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

An bayyana waɗannan manufofi a cikin [Makefile](../../../Makefile). Molecule yana buƙatar direbansa da abubuwan dogaron gwaji. Manufofin Docker suna amfani da fayiloli ƙarƙashin [dev](../../../dev); `make docker-test` shi ne ainihin manufar Docker ta asali, ba `make test-docker` ba.

## Takardu, tsaro, da lasisi

- [Misalan saiti](../../../docs/README.md)
- [Ba da gudummawa](../../../CONTRIBUTING.md)
- [Manufar tsaro](../../../SECURITY.md)
- [Lasisin MIT](../../../LICENSE)
