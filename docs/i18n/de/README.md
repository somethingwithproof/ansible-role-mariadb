<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Deutsch** · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · **Deutsch** · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# MariaDB Ansible Role

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Eine Ansible-Rolle zum Installieren von MariaDB, Bereitstellen von Datenbanken und Benutzern sowie zum Konfigurieren optionaler Backup- und Monitoring-Aufgaben. Die Rolle trennt Installation, Konfiguration, Validierung und Betriebsaufgaben, sodass jeder Bereich unabhängig geprüft werden kann.

## Funktionsumfang

| Bereich | Implementierung |
| --- | --- |
| Installation und Konfiguration | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml) und Konfigurationsvorlagen |
| Eingabevalidierung und Kontoeinrichtung | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Datenbankbereitstellung | [databases.yml](../../../tasks/databases.yml) |
| Replikationseinstellungen | [replication.yml](../../../tasks/replication.yml) setzt Server-IDs sowie primärseitige Binary-Logging- und Benutzereinstellungen |
| Geplante Backups | [backup.yml](../../../tasks/backup.yml) und die [Backup-Skriptvorlage](../../../templates/mariadb_backup.sh.j2) |
| Monitoring | [monitoring.yml](../../../tasks/monitoring.yml) sowie Exporter- und Check-Vorlagen |

Die eingecheckten Replikationsaufgaben implementieren weder automatisches Failover noch eine vollständige Replica-Initialisierung. Mehrere Molecule-Instanzen bilden eine Testtopologie ab und sind kein Nachweis für den Betrieb mehrerer Instanzen auf einem einzelnen Host. Prüfen Sie Backup-Verschlüsselung, Wiederherstellungsverhalten und Datenbankversions-Kompatibilität für Ihre Bereitstellung; diese werden durch dieses README nicht garantiert.

## Installation und Verwendung

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

Stellen Sie die referenzierten Passwortvariablen über Ansible Vault oder Ihr Secret-Management-System bereit. Die tatsächlichen Optionsnamen und Standardwerte finden Sie in [defaults/main.yml](../../../defaults/main.yml).

## Anforderungen und Kompatibilität

Der aktuelle Controller ist Ansible 14.5.0 / ansible-core 2.21.5 mit Python 3.13. Das Szenario `lts` testet native Distributionspakete auf Ubuntu 22.04, 24.04 und 26.04, Debian 12 und 13 sowie Rocky Linux 9 und 10. EL-Aliase in den Metadaten begründen keine eigenständige RHEL- oder AlmaLinux-Zertifizierung.

Native Distributionspakete sind auf jeder getesteten Plattform die Standardeinstellung. Bestehende externe Repository-Dateien werden nicht entfernt, und die Rolle migriert keinen installierten Server zwischen Paketquellen oder Hauptversionen. Prüfen Sie Paketmanager-Konflikte, bevor Sie eine bestehende externe Installation migrieren.

Der externe Repository-Pfad ist ein explizites, ungetestetes Opt-in über `mariadb_configure_repo: true`. Der Legacy-Selektor `mariadb_version` entspricht weder einer nativen Serverversion noch einer Empfehlung für ein unterstütztes Upstream-Release. Die alten fest codierten Spiegelserver decken nicht jede aktuelle Distribution ab; verwenden Sie den nativen Standard oder prüfen Sie die Repository-Konfiguration vorab eigenständig.

Die Rolle ermittelt die Version und das Datenverzeichnis des laufenden Servers, bevor sie Konfigurationen schreibt. Dadurch bleiben `/var/lib/mariadb` unter Ubuntu 26.04 und bestehende Datenbankbestände erhalten. Ein explizit widersprüchlicher Wert für `mariadb_data_dir` schlägt mit einer Migrationsanforderung fehl; die Rolle verschiebt keine Daten. Öffentliche Überschreibungen für Pakete, Dienste, Sockets und Konfigurationsdateien bleiben weiterhin verfügbar.

Passwortänderungen verwenden parametrisierte Anweisungen, damit MariaDB sein striktes Passwortvalidierungs-Plugin durchsetzen kann. Die private Client-Datei von Root nutzt den lokalen Unix-Socket. Unveränderte Konten behalten ihre Berechtigungen und Passwörter.

## Entwicklung und Tests

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Diese Targets sind im [Makefile](../../../Makefile) definiert. Molecule benötigt seinen Treiber sowie die Testabhängigkeiten. Docker-Targets verwenden Dateien unter [dev](../../../dev); `make docker-test` ist das grundlegende Docker-Target, nicht `make test-docker`.

## Dokumentation, Sicherheit und Lizenz

- [Konfigurationsbeispiele](../../../docs/README.md)
- [Mitwirken](../../../CONTRIBUTING.md)
- [Sicherheitsrichtlinie](../../../SECURITY.md)
- [MIT-Lizenz](../../../LICENSE)
