<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Afrikaans** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** **Afrikaans** · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# MariaDB Ansible-rol

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

'n Ansible-rol vir die installering van MariaDB, die voorsiening van databasisse en gebruikers, en die konfigurasie van opsionele rugsteun- en moniteringstake. Die rol skei installasie-, konfigurasie-, validerings- en bedryfstake sodat elkeen onafhanklik hersien kan word.

## Vermoëns

| Gebied | Implementering |
| --- | --- |
| Installasie en konfigurasie | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml) en konfigurasiesjablone |
| Invoervalidering en rekeningopstelling | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Databasisvoorsiening | [databases.yml](../../../tasks/databases.yml) |
| Replikasie-instellings | [replication.yml](../../../tasks/replication.yml) stel bediener-ID's en primêrekant-binêre logboek-/gebruikerinstellings op |
| Geskeduleerde rugsteune | [backup.yml](../../../tasks/backup.yml) en die [rugsteunskrip-sjabloon](../../../templates/mariadb_backup.sh.j2) |
| Monitering | [monitoring.yml](../../../tasks/monitoring.yml) en uitvoerder-/kontrolesjablone |

Die ingeboekte replikasietake implementeer nie geoutomatiseerde foutoorskakeling of volledige replika-inisialisering nie. Veelvuldige Molecule-instansies is 'n toetstopologie, nie bewys van multi-instansie-ontplooiing op een gasheer nie. Hersien rugsteunenkripsie, herstelgedrag en databasisweergawe-versoenbaarheid vir jou ontplooiing; dit word nie deur hierdie README gewaarborg nie.

## Installeer en gebruik

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

Verskaf die verwysde wagwoordveranderlikes deur middel van Ansible Vault of jou geheimbestuurstelsel. Gebruik [defaults/main.yml](../../../defaults/main.yml) vir die werklike opsiename en verstekwaardes.

## Vereistes en versoenbaarheid

Die huidige beheerder is Ansible 14.5.0 / ansible-core 2.21.5 met Python
3.13. Die `lts`-scenario toets inheemse verspreidingspakkette op Ubuntu
22.04, 24.04 en 26.04, Debian 12 en 13, en Rocky Linux 9 en 10. EL-aliasse
in metadata vestig nie afsonderlike RHEL- of AlmaLinux-sertifisering nie.

Inheemse verspreidingspakkette is die verstek op elke getoetste platform.
Bestaande eksterne bewaarpleklêers word nie verwyder nie, en die rol migreer
nie 'n geïnstalleerde bediener tussen pakketbronne of hoofweergawes nie.
Hersien pakketbestuurder-konflikte voordat 'n bestaande eksterne installasie
gemigreer word.

Die eksterne bewaarplekpad is 'n eksplisiete, ongetoetste intekening deur
middel van `mariadb_configure_repo: true`. Sy ouer `mariadb_version`-kieser
is nie 'n inheemse bedienerweergawe of 'n aanbeveling vir 'n ondersteunde
stroomop-vrystelling nie. Die ou hardgekodeerde spieëlbedieners dek nie elke
huidige verspreiding nie; gebruik die inheemse verstek of kwalifiseer eers
die bewaarplekkonfigurasie onafhanklik.

Die rol ontdek die lopende bediener se weergawe en datagids voordat
konfigurasie geskryf word. Dit behou Ubuntu 26.04 se `/var/lib/mariadb` en
bestaande databasisberging. 'n Eksplisiete botsende `mariadb_data_dir` misluk
met 'n migrasievereiste; die rol skuif nie data nie. Openbare pakket-,
diens-, sok- en konfigurasielêer-oorheersings bly beskikbaar.

Wagwoordveranderinge gebruik geparametriseerde stellings sodat MariaDB sy
streng wagwoordvalidering-inprop kan afdwing. Root se private kliëntlêer
gebruik die plaaslike Unix-sok. Onveranderde rekeninge behou hul regte en
wagwoorde.

## Ontwikkeling en toetsing

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Hierdie teikens word in die [Makefile](../../../Makefile) gedefinieer. Molecule vereis sy drywer en toetsafhanklikhede. Docker-teikens gebruik lêers onder [dev](../../../dev); `make docker-test` is die basiese Docker-teiken, nie `make test-docker` nie.

## Dokumentasie, sekuriteit en lisensie

- [Konfigurasievoorbeelde](../../../docs/README.md)
- [Bydraes](../../../CONTRIBUTING.md)
- [Sekuriteitsbeleid](../../../SECURITY.md)
- [MIT-lisensie](../../../LICENSE)
