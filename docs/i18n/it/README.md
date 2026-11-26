<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Italiano** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · **Italiano** · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Ruolo Ansible MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Un ruolo Ansible per installare MariaDB, effettuare il provisioning di database e utenti e configurare task opzionali di backup e monitoraggio. Il ruolo separa installazione, configurazione, validazione e task operativi affinché ciascuno possa essere esaminato in modo indipendente.

## Funzionalità

| Area | Implementazione |
| --- | --- |
| Installazione e configurazione | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml) e template di configurazione |
| Validazione degli input e configurazione degli account | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Provisioning dei database | [databases.yml](../../../tasks/databases.yml) |
| Impostazioni di replica | [replication.yml](../../../tasks/replication.yml) imposta gli ID dei server e le impostazioni di binary logging/utenti lato primario |
| Backup pianificati | [backup.yml](../../../tasks/backup.yml) e il [template dello script di backup](../../../templates/mariadb_backup.sh.j2) |
| Monitoraggio | [monitoring.yml](../../../tasks/monitoring.yml) e template di exporter/controlli |

I task di replica inclusi nel repository non implementano il failover automatico né l'inizializzazione completa delle repliche. Le istanze multiple di Molecule costituiscono una topologia di test, non una prova di deployment multi-istanza su un singolo host. Verifica la crittografia dei backup, il comportamento del ripristino e la compatibilità della versione del database per il tuo deployment; non sono garantiti da questo README.

## Installazione e utilizzo

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

Fornisci le variabili delle password referenziate tramite Ansible Vault o il tuo sistema di gestione dei segreti. Consulta [defaults/main.yml](../../../defaults/main.yml) per i nomi effettivi delle opzioni e i relativi valori predefiniti.

## Requisiti e compatibilità

Il controller attuale è Ansible 14.5.0 / ansible-core 2.21.5 con Python
3.13. Lo scenario `lts` testa i pacchetti nativi della distribuzione su Ubuntu
22.04, 24.04 e 26.04, Debian 12 e 13, e Rocky Linux 9 e 10. Gli alias EL
nei metadati non stabiliscono una certificazione separata per RHEL o AlmaLinux.

I pacchetti nativi della distribuzione sono l'impostazione predefinita su ogni piattaforma testata.
I file di repository esterni esistenti non vengono rimossi e il ruolo non
migra un server installato tra sorgenti di pacchetti o major version diverse. Verifica
eventuali conflitti del gestore di pacchetti prima di migrare un'installazione esterna esistente.

Il percorso dei repository esterni è un opt-in esplicito e non testato tramite
`mariadb_configure_repo: true`. Il selettore legacy `mariadb_version` non indica una
versione del server nativo né una raccomandazione per una release upstream supportata.
I vecchi mirror codificati in modo statico non coprono tutte le distribuzioni attuali; usa il
valore predefinito nativo oppure qualifica prima in modo indipendente la configurazione del repository.

Il ruolo rileva la versione e la directory dei dati del server in esecuzione prima
di scrivere la configurazione. Ciò preserva `/var/lib/mariadb` su Ubuntu 26.04 e
lo storage esistente del database. Una variabile `mariadb_data_dir` esplicita in conflitto fallisce
richiedendo una migrazione; il ruolo non sposta i dati. Restano disponibili gli override pubblici per pacchetti,
servizio, socket e file di configurazione.

Le modifiche delle password utilizzano istruzioni parametrizzate in modo che MariaDB possa applicare il proprio
plugin rigoroso di validazione delle password. Il file client privato di root usa il
socket Unix locale. Gli account invariati mantengono i propri privilegi e le proprie password.

## Sviluppo e test

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Questi target sono definiti nel [Makefile](../../../Makefile). Molecule richiede il proprio driver e le dipendenze di test. I target Docker utilizzano i file in [dev](../../../dev); `make docker-test` è il target Docker di base, non `make test-docker`.

## Documentazione, sicurezza e licenza

- [Esempi di configurazione](../../../docs/README.md)
- [Contribuire](../../../CONTRIBUTING.md)
- [Policy di sicurezza](../../../SECURITY.md)
- [Licenza MIT](../../../LICENSE)
