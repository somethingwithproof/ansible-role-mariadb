<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Svenska** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · **Svenska** · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# MariaDB Ansible-roll

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

En Ansible-roll för att installera MariaDB, tillhandahålla databaser och användare samt konfigurera valfria uppgifter för säkerhetskopiering och övervakning. Rollen separerar installations-, konfigurations-, validerings- och driftsuppgifter så att varje del kan granskas oberoende.

## Funktioner

| Område | Implementering |
| --- | --- |
| Installation och konfiguration | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml) och konfigurationsmallar |
| Indatavalidering och kontokonfiguration | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Databasprovisionering | [databases.yml](../../../tasks/databases.yml) |
| Replikeringsinställningar | [replication.yml](../../../tasks/replication.yml) anger server-ID:n samt inställningar för binärloggning och användare på primärsidan |
| Schemalagda säkerhetskopior | [backup.yml](../../../tasks/backup.yml) och [mallen för säkerhetskopieringsskript](../../../templates/mariadb_backup.sh.j2) |
| Övervakning | [monitoring.yml](../../../tasks/monitoring.yml) samt exportör- och kontrollmallar |

De incheckade replikeringsuppgifterna implementerar inte automatisk redundansväxling eller fullständig initiering av repliker. Flera Molecule-instanser utgör en testtopologi, inte bevis på driftsättning av flera instanser på samma värd. Granska kryptering av säkerhetskopior, återställningsbeteende och kompatibilitet mellan databasversioner för din driftsättning; dessa garanteras inte av denna README.

## Installation och användning

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

Tillhandahåll de refererade lösenordsvariablerna via Ansible Vault eller ditt system för hemlighetshantering. Använd [defaults/main.yml](../../../defaults/main.yml) för de faktiska alternativnamnen och standardvärdena.

## Krav och kompatibilitet

Den aktuella kontrollnoden är Ansible 14.5.0 / ansible-core 2.21.5 med Python 3.13. Scenariot `lts` testar distributionens egna paket på Ubuntu 22.04, 24.04 och 26.04, Debian 12 och 13 samt Rocky Linux 9 och 10. EL-alias i metadata utgör inte separat certifiering för RHEL eller AlmaLinux.

Distributionens egna paket är standard på varje testad plattform. Befintliga externa förrådsfiler tas inte bort, och rollen migrerar inte en installerad server mellan paketkällor eller huvudversioner. Granska konflikter i pakethanteraren innan du migrerar en befintlig extern installation.

Sökvägen för externt paketförråd är ett uttryckligt, otestat tillval via `mariadb_configure_repo: true`. Dess äldre väljare `mariadb_version` är inte en version för distributionens egen server och inte heller en rekommendation för en uppströmsutgåva som stöds. De gamla hårdkodade speglarna täcker inte varje aktuell distribution; använd distributionens standardval eller verifiera förrådskonfigurationen på egen hand först.

Rollen identifierar den körande serverns version och datakatalog innan konfigurationen skrivs. Detta bevarar `/var/lib/mariadb` på Ubuntu 26.04 samt befintlig databaslagring. En uttryckligt motstridig `mariadb_data_dir` misslyckas med ett migreringskrav; rollen flyttar inte data. Publika åsidosättningar för paket, tjänst, socket och konfigurationsfil förblir tillgängliga.

Lösenordsändringar använder parametriserade satser så att MariaDB kan tillämpa sitt strikta insticksprogram för lösenordsvalidering. Roots privata klientfil använder den lokala Unix-socketen. Oförändrade konton behåller sina behörigheter och lösenord.

## Utveckling och testning

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Dessa mål definieras i [Makefile](../../../Makefile). Molecule kräver sin drivrutin och sina testberoenden. Docker-mål använder filer under [dev](../../../dev); `make docker-test` är det grundläggande Docker-målet, inte `make test-docker`.

## Dokumentation, säkerhet och licens

- [Konfigurationsexempel](../../../docs/README.md)
- [Bidra](../../../CONTRIBUTING.md)
- [Säkerhetspolicy](../../../SECURITY.md)
- [MIT-licens](../../../LICENSE)
