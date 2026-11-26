<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Malagasy** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · **Malagasy** · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Anjara asa Ansible ho an'ny MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Anjara asa Ansible natao hametrahana MariaDB, hanomezana angon-drakitra sy mpampiasa, ary handrindrana asa tahiry fiarovana (backup) sy fanaraha-maso tsy voatery. Manasaraka ny fametrahana, ny fandrindrana, ny fanamarinana, ary ny asa fampandehanana ity anjara asa ity mba ho azo jerena mitokana ny tsirairay.

## Fahaiza-manao

| Sehatra | Fampiharana |
| --- | --- |
| Fametrahana sy fandrindrana | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml), ary modely fandrindrana |
| Fanamarinana fampidirana sy fanomanana kaonty | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Fanomezana angon-drakitra | [databases.yml](../../../tasks/databases.yml) |
| Fandrindrana dika mitovy (replication) | Ny [replication.yml](../../../tasks/replication.yml) dia mametraka ny ID-n'ny mpizara sy ny firaketana binary logging/mpampiasa eo amin'ny lafiny voalohany (primary) |
| Tahiry fiarovana voalahatra | [backup.yml](../../../tasks/backup.yml) sy ny [modely soratra tahiry fiarovana](../../../templates/mariadb_backup.sh.j2) |
| Fanaraha-maso | [monitoring.yml](../../../tasks/monitoring.yml) sy ny modely exporter/fanamarinana |

Tsy mampihatra fiverenana ho azy (automated failover) na fanombohana replica feno ireo asa replication voarakitra. Ny tranga Molecule maromaro dia endrika fitsapana fotsiny, fa tsy porofon'ny fametrahana tranga maromaro eo amin'ny mpampiantrano tokana. Hamarino ny fanafenana (encryption) ny tahiry fiarovana, ny fihetsiky ny famerenana, ary ny fifanarahana amin'ny dika angon-drakitra ho an'ny fametrahanao; tsy iantohan'ity README ity izany.

## Fametrahana sy fampiasana

```bash
ansible-galaxy role install git+https://github.com/somethingwithproof/ansible-role-mariadb.git
ansible-galaxy collection install community.mysql
```

```yaml
- hosts: database_servers
  become: true
  vars:
    mariadb_configure_repo: false
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

Omeo amin'ny alalan'ny Ansible Vault na ny rafitra fitantanana tsiambaratelonao ireo miovaova tenimiafina voatondro. Ampiasao ny [defaults/main.yml](../../../defaults/main.yml) ho an'ny tena anaran'ny safidy sy ny soatoavina fototra.

## Fepetra takiana sy fifanarahana

Ny mpibaiko (controller) ankehitriny dia Ansible 14.5.0 / ansible-core 2.21.5 miaraka amin'ny Python 3.13. Ny sehatra fitsapana `lts` dia mitsapa fonosana voajanahary avy amin'ny fizarana amin'ny Ubuntu 22.04, 24.04 ary 26.04, Debian 12 sy 13, ary Rocky Linux 9 sy 10. Ny solonanarana EL ao amin'ny metadata dia tsy manamarina fanamarinana manokana ho an'ny RHEL na AlmaLinux.

Fonosana voajanahary avy amin'ny fizarana no safidy fototra amin'ny sehatra voatsapa rehetra. Tsy esorina ireo rakitra tahiry ivelany efa misy, ary tsy mamindra mpizara efa napetraka eo anelanelan'ny loharanom-ponosana na dika lehibe ny anjara asa. Hamarino ny fifandirana amin'ny mpitantana fonosana alohan'ny hamindrana fametrahana ivelany efa misy.

Ny lalan'ny tahiry ivelany dia safidy an-tsitrapo mazava sy tsy voatsapa amin'ny alalan'ny `mariadb_configure_repo: true`. Ny mpisafidy `mariadb_version` teo aloha dia tsy dika mpizara voajanahary na soso-kevitra ho an'ny famoahana loharano ambony tohanana. Tsy mahafaoka ny fizarana ankehitriny rehetra ireo fitaratra (mirrors) taloha voasoratra raikitra; ampiasao ny safidy fototra voajanahary na hamarino mahaleo tena aloha ny fandrindrana ny tahiry.

Mamantatra ny dika sy ny lahatahirin'angon-drakitry ny mpizara mandeha ny anjara asa alohan'ny hanoratana fandrindrana. Izany dia mitahiry ny `/var/lib/mariadb` an'ny Ubuntu 26.04 sy ny fitahirizana angon-drakitra efa misy. Ny `mariadb_data_dir` mifanditra voatondro mazava dia tsy mahomby miaraka amin'ny fepetra famindrana; tsy mamindra angon-drakitra ny anjara asa. Mijanona ho azo ampiasaina ireo fanovana ho an'ny daholobe momba ny fonosana, tolotra, socket, ary rakitra fandrindrana.

Mampiasa fanambarana misy masontsivana (parameterized statements) ny fanovana tenimiafina mba hahafahan'ny MariaDB mampihatra ny plugin fanamarinana tenimiafina henjana. Mampiasa ny Unix socket eo an-toerana ny rakitra mpanjifa manokana an'ny root. Mitazona ny alalany sy ny tenimiafiny ireo kaonty tsy niova.

## Fampandrosoana sy fitsapana

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Voafaritra ao amin'ny [Makefile](../../../Makefile) ireo tanjona ireo. Mila ny mpamily (driver) sy ny fiankinan-doha fitsapana ny Molecule. Ny tanjona Docker dia mampiasa rakitra ao ambanin'ny [dev](../../../dev); ny `make docker-test` no tanjona Docker fototra, fa tsy `make test-docker`.

## Antontan-taratasy, fiarovana, ary fahazoan-dalana

- [Ohatra fandrindrana](../../../docs/README.md)
- [Fandraisana anjara](../../../CONTRIBUTING.md)
- [Politika momba ny fiarovana](../../../SECURITY.md)
- [Fahazoan-dalana MIT](../../../LICENSE)
