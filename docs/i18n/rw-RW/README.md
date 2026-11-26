<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Kinyarwanda** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · **Kinyarwanda** · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Inshingano ya Ansible ya MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Inshingano ya Ansible igenewe gushyiraho MariaDB, gukora ububiko bw'amakuru n'abakoresha, no gutegura imirimo ihitamo yo kubika ikopi no kugenzura imikorere. Iyi nshingano itandukanya ishyiraho, igenamiterere, igenzura, n'imirimo y'imikorere kugira ngo buri gice gisuzumwe ukwacyo.

## Ubushobozi

| Igice | Ishyirwa mu bikorwa |
| --- | --- |
| Gushyiraho no gutegura | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml), n'inyandikorugero z'igenamiterere |
| Igenzura ry'amakuru yinjijwe n'itegurwa rya konti | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Gukora ububiko bw'amakuru | [databases.yml](../../../tasks/databases.yml) |
| Igenamiterere ry'iyigana (replication) | [replication.yml](../../../tasks/replication.yml) ishyiraho indangamashini za seriveri n'igenamiterere ry'inyandiko za binary/abakoresha ku ruhande rw'ibanze |
| Kubika ikopi ku gihe cyagenwe | [backup.yml](../../../tasks/backup.yml) n'[inyandikorugero ya script yo kubika ikopi](../../../templates/mariadb_backup.sh.j2) |
| Kugenzura imikorere | [monitoring.yml](../../../tasks/monitoring.yml) n'inyandikorugero za exporter/igenzura |

Imirimo y'iyigana iri mu bubiko ntishyira mu bikorwa kwimuka kwikora igihe habayeho ikibazo cyangwa itangiza ryuzuye rya replica. Ingero nyinshi za Molecule ni imiterere y'igerageza, si ikimenyetso cyo gushyira mu bikorwa ingero nyinshi ku mashini imwe. Suzuma ishyirwa mu ibanga ry'ikopi z'ububiko, imikorere yo gusubizaho, n'imikoranire ya verisiyo y'ububiko bw'amakuru ku ishyirwa mu bikorwa ryawe; ntibyizezwa n'iyi README.

## Gushyiraho no gukoresha

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

Tanga ibihindagurika by'ijambobanga byavuzwe binyuze muri Ansible Vault cyangwa sisitemu yawe icunga amabanga. Koresha [defaults/main.yml](../../../defaults/main.yml) kugira ngo ubone amazina nyayo y'amahitamo n'indangagaciro mbanziriza.

## Ibisabwa n'imikoranire

Umugenzuzi ukoreshwa ubu ni Ansible 14.5.0 / ansible-core 2.21.5 hamwe na Python
3.13. Icyitegererezo cya `lts` kigerageza paki gakondo za disitiribisiyo kuri Ubuntu
22.04, 24.04 na 26.04, Debian 12 na 13, na Rocky Linux 9 na 10. Amazina ahagarariye EL
ari mu makuru aranga paki ntayemeza icyemezo cyihariye cya RHEL cyangwa AlmaLinux.

Paki gakondo za disitiribisiyo ni zo mbanziriza kuri buri rubuga rwageragejwe.
Amadosiye y'ububiko bwo hanze asanzwe ahari ntakurwaho, kandi inshingano
ntiyimura seriveri isanzwe ishyizweho hagati y'amasoko ya paki cyangwa verisiyo nkuru. Suzuma
amakimbirane y'umucungamapaki mbere yo kwimura ishyiraho ryo hanze risanzwe rihari.

Inzira y'ububiko bwo hanze ni ihitamo ryihariye ritarageragezwa rikoreshwa binyuze kuri
`mariadb_configure_repo: true`. Igihitamo cyayo cya kera `mariadb_version` si
verisiyo ya seriveri gakondo cyangwa inama y'isohorwa ry'isoko y'ibanze rishyigikiwe.
Indorerwamo za kera zanditswe mu buryo budahinduka ntizireba buri disitiribisiyo y'ubu; koresha
uburyo gakondo mbanziriza cyangwa ubanze usuzume ku giti cyawe igenamiterere ry'ububiko.

Inshingano imenya verisiyo ya seriveri iri gukora n'ububiko bw'amakuru mbere yo
kwandika igenamiterere. Ibi bibungabunga `/var/lib/mariadb` ya Ubuntu 26.04
n'ububiko bw'amakuru busanzwe buhari. `mariadb_data_dir` igaragajwe ku mugaragaro ivuguruzanya iratsindwa
igatera icyifuzo cyo kwimura; inshingano ntiyimura amakuru. Guhindura rusange paki,
serivisi, socket n'idosiye y'igenamiterere bikomeza kuboneka.

Impinduka z'ijambobanga zikoresha amagambo afite parametere kugira ngo MariaDB ishobore gukurikiza
umugereka wayo ukomeye wo kugenzura ijambobanga. Idosiye yihariye y'umukiriya wa root ikoresha
socket ya Unix y'imbere. Konti zitahinduwe zigumana uburenganzira bwazo n'amajambobanga yazo.

## Iterambere n'igerageza

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Izi ntego zisobanurwa muri [Makefile](../../../Makefile). Molecule ikenera driver yayo n'ibikenerwa mu igerageza. Intego za Docker zikoresha amadosiye ari muri [dev](../../../dev); `make docker-test` ni yo ntego y'ibanze ya Docker, si `make test-docker`.

## Inyandiko, umutekano, n'uruhushya

- [Ingero z'igenamiterere](../../../docs/README.md)
- [Gutanga umusanzu](../../../CONTRIBUTING.md)
- [Politiki y'umutekano](../../../SECURITY.md)
- [Uruhushya rwa MIT](../../../LICENSE)
