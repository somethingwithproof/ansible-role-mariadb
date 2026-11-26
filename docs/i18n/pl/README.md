<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Polski** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · **Polski** · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Rola Ansible dla MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Rola Ansible do instalacji MariaDB, tworzenia baz danych i użytkowników oraz konfigurowania opcjonalnych zadań tworzenia kopii zapasowych i monitoringu. Rola rozdziela zadania instalacji, konfiguracji, walidacji i obsługi operacyjnej, umożliwiając ich niezależny przegląd.

## Możliwości

| Obszar | Implementacja |
| --- | --- |
| Instalacja i konfiguracja | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml) oraz szablony konfiguracji |
| Walidacja danych wejściowych i konfiguracja kont | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Tworzenie baz danych | [databases.yml](../../../tasks/databases.yml) |
| Ustawienia replikacji | [replication.yml](../../../tasks/replication.yml) ustawia identyfikatory serwerów oraz konfigurację logów binarnych i użytkowników po stronie serwera głównego |
| Zaplanowane kopie zapasowe | [backup.yml](../../../tasks/backup.yml) oraz [szablon skryptu kopii zapasowej](../../../templates/mariadb_backup.sh.j2) |
| Monitoring | [monitoring.yml](../../../tasks/monitoring.yml) oraz szablony eksporterów i testów kontrolnych |

Zadania replikacji zawarte w repozytorium nie implementują automatycznego przełączania awaryjnego ani pełnej inicjalizacji repliki. Wiele instancji Molecule stanowi topologię testową, a nie potwierdzenie wdrożenia wielu instancji na jednym hoście. Zweryfikuj szyfrowanie kopii zapasowych, zachowanie przy przywracaniu oraz zgodność wersji bazy danych dla swojego wdrożenia; niniejszy plik README tego nie gwarantuje.

## Instalacja i użycie

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

Przekaż wskazane zmienne haseł przez Ansible Vault lub swój system zarządzania sekretami. Rzeczywiste nazwy opcji i wartości domyślne znajdziesz w [defaults/main.yml](../../../defaults/main.yml).

## Wymagania i kompatybilność

Obecnym kontrolerem jest Ansible 14.5.0 / ansible-core 2.21.5 z Pythonem
3.13. Scenariusz `lts` testuje natywne pakiety dystrybucji na Ubuntu
22.04, 24.04 i 26.04, Debian 12 i 13 oraz Rocky Linux 9 i 10. Aliasy EL
w metadanych nie stanowią odrębnej certyfikacji dla RHEL ani AlmaLinux.

Natywne pakiety dystrybucji są domyślne na każdej testowanej platformie.
Istniejące pliki zewnętrznych repozytoriów nie są usuwane, a rola nie
migruje zainstalowanego serwera między źródłami pakietów ani głównymi wersjami.
Przed migracją istniejącej instalacji z zewnętrznego repozytorium sprawdź konflikty menedżera pakietów.

Ścieżka zewnętrznego repozytorium jest jawną, nietestowaną opcją włączaną przez
`mariadb_configure_repo: true`. Jej starszy selektor `mariadb_version` nie określa
wersji natywnego serwera ani nie stanowi rekomendacji wspieranego wydania projektu nadrzędnego.
Stare, zakodowane na stałe serwery lustrzane nie obejmują wszystkich obecnych dystrybucji; korzystaj
z domyślnych pakietów natywnych lub najpierw samodzielnie zweryfikuj konfigurację repozytorium.

Przed zapisaniem konfiguracji rola wykrywa wersję uruchomionego serwera oraz jego katalog danych.
Pozwala to zachować katalog `/var/lib/mariadb` w Ubuntu 26.04 oraz
istniejące dane baz. Jawnie ustawiona, sprzeczna wartość `mariadb_data_dir` kończy się błędem
z wymogiem migracji; rola nie przenosi danych. Publiczne nadpisania pakietów,
usług, gniazd i plików konfiguracyjnych pozostają dostępne.

Zmiany haseł wykorzystują zapytania parametryzowane, dzięki czemu MariaDB może egzekwować
rygorystyczną wtyczkę walidacji haseł. Prywatny plik klienta dla użytkownika root używa lokalnego
gniazda Unix. Niezmienione konta zachowują swoje uprawnienia i hasła.

## Rozwój i testowanie

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Te cele są zdefiniowane w pliku [Makefile](../../../Makefile). Molecule wymaga własnego sterownika i zależności testowych. Cele Docker korzystają z plików w katalogu [dev](../../../dev); podstawowym celem dla Dockera jest `make docker-test`, a nie `make test-docker`.

## Dokumentacja, bezpieczeństwo i licencja

- [Przykłady konfiguracji](../../../docs/README.md)
- [Współtworzenie](../../../CONTRIBUTING.md)
- [Polityka bezpieczeństwa](../../../SECURITY.md)
- [Licencja MIT](../../../LICENSE)
