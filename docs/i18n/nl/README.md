<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Nederlands** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · **Nederlands** · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# MariaDB Ansible-rol

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Een Ansible-rol voor het installeren van MariaDB, het inrichten van databases en gebruikers, en het configureren van optionele back-up- en monitoringtaken. De rol scheidt installatie-, configuratie-, validatie- en operationele taken zodat elk onderdeel afzonderlijk kan worden beoordeeld.

## Mogelijkheden

| Onderdeel | Implementatie |
| --- | --- |
| Installatie en configuratie | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml) en configuratiesjablonen |
| Invoervalidatie en accountinrichting | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Database-inrichting | [databases.yml](../../../tasks/databases.yml) |
| Replicatie-instellingen | [replication.yml](../../../tasks/replication.yml) stelt server-ID's en binaire logging-/gebruikersinstellingen aan de primaire zijde in |
| Geplande back-ups | [backup.yml](../../../tasks/backup.yml) en het [back-upscriptsjabloon](../../../templates/mariadb_backup.sh.j2) |
| Monitoring | [monitoring.yml](../../../tasks/monitoring.yml) en exporter-/controlesjablonen |

De ingecheckte replicatietaken implementeren geen geautomatiseerde failover of volledige replica-initialisatie. Meerdere Molecule-instanties vormen een testtopologie, geen bewijs voor een uitrol van meerdere instanties op één host. Beoordeel back-upversleuteling, herstelgedrag en compatibiliteit tussen databaseversies voor jouw uitrol; deze worden niet door deze README gegarandeerd.

## Installeren en gebruiken

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

Lever de genoemde wachtwoordvariabelen aan via Ansible Vault of je secret-managementsysteem. Gebruik [defaults/main.yml](../../../defaults/main.yml) voor de daadwerkelijke optienamen en standaardwaarden.

## Vereisten en compatibiliteit

De huidige controller is Ansible 14.5.0 / ansible-core 2.21.5 met Python 3.13. Het `lts`-scenario test native distributiepakketten op Ubuntu 22.04, 24.04 en 26.04, Debian 12 en 13, en Rocky Linux 9 en 10. EL-aliassen in metadata vormen geen afzonderlijke RHEL- of AlmaLinux-certificering.

Native distributiepakketten zijn de standaard op elk getest platform. Bestaande externe repositorybestanden worden niet verwijderd, en de rol migreert een geïnstalleerde server niet tussen pakketbronnen of hoofdversies. Controleer pakketbeheerconflicten voordat je een bestaande externe installatie migreert.

Het externe repositorypad is een expliciete, ongeteste opt-in via `mariadb_configure_repo: true`. De verouderde `mariadb_version`-selector is geen native serverversie en geen aanbeveling voor een ondersteunde upstream-release. De oude vastgelegde mirrors dekken niet elke huidige distributie; gebruik de native standaard of valideer de repositoryconfiguratie eerst zelfstandig.

De rol detecteert de versie en datamap van de draaiende server voordat configuratie wordt weggeschreven. Hierdoor blijven `/var/lib/mariadb` op Ubuntu 26.04 en bestaande database-opslag behouden. Een expliciet conflicterende `mariadb_data_dir` faalt met een migratievereiste; de rol verplaatst geen gegevens. Publieke overschrijvingen voor pakket, service, socket en configuratiebestand blijven beschikbaar.

Wachtwoordwijzigingen gebruiken geparametriseerde statements zodat MariaDB de strikte wachtwoordvalidatie-plug-in kan afdwingen. Het privé-clientbestand van root gebruikt de lokale Unix-socket. Ongewijzigde accounts behouden hun rechten en wachtwoorden.

## Ontwikkeling en testen

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Deze targets zijn gedefinieerd in de [Makefile](../../../Makefile). Molecule vereist zijn driver en testafhankelijkheden. Docker-targets gebruiken bestanden onder [dev](../../../dev); `make docker-test` is het basis-Docker-target, niet `make test-docker`.

## Documentatie, beveiliging en licentie

- [Configuratievoorbeelden](../../../docs/README.md)
- [Bijdragen](../../../CONTRIBUTING.md)
- [Beveiligingsbeleid](../../../SECURITY.md)
- [MIT-licentie](../../../LICENSE)
