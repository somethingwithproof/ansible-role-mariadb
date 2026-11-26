<!-- translations:start -->
**Languages:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · **Français** · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · **Français** · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Rôle Ansible MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Un rôle Ansible permettant d'installer MariaDB, de provisionner des bases de données et des utilisateurs, et de configurer des tâches optionnelles de sauvegarde et de supervision. Le rôle sépare l'installation, la configuration, la validation et les tâches opérationnelles afin que chacune puisse être examinée indépendamment.

## Fonctionnalités

| Domaine | Implémentation |
| --- | --- |
| Installation et configuration | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml) et modèles de configuration |
| Validation des entrées et configuration des comptes | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Provisionnement des bases de données | [databases.yml](../../../tasks/databases.yml) |
| Paramètres de réplication | [replication.yml](../../../tasks/replication.yml) définit les identifiants de serveur ainsi que les paramètres de journalisation binaire et d'utilisateur côté primaire |
| Sauvegardes planifiées | [backup.yml](../../../tasks/backup.yml) et le [modèle de script de sauvegarde](../../../templates/mariadb_backup.sh.j2) |
| Supervision | [monitoring.yml](../../../tasks/monitoring.yml) et modèles d'exportateurs et de vérifications |

Les tâches de réplication incluses n'implémentent pas de basculement automatique ni d'initialisation complète de réplica. Les instances Molecule multiples constituent une topologie de test, et non la preuve d'un déploiement multi-instance sur un même hôte. Vérifiez le chiffrement des sauvegardes, le comportement de restauration et la compatibilité des versions de base de données pour votre déploiement ; ces aspects ne sont pas garantis par ce README.

## Installation et utilisation

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

Fournissez les variables de mot de passe référencées via Ansible Vault ou votre système de gestion de secrets. Consultez [defaults/main.yml](../../../defaults/main.yml) pour connaître les noms exacts des options et leurs valeurs par défaut.

## Prérequis et compatibilité

Le contrôleur actuel est Ansible 14.5.0 / ansible-core 2.21.5 avec Python 3.13. Le scénario `lts` teste les paquets natifs de la distribution sur Ubuntu 22.04, 24.04 et 26.04, Debian 12 et 13, ainsi que Rocky Linux 9 et 10. Les alias EL dans les métadonnées n'établissent pas de certification distincte pour RHEL ou AlmaLinux.

Les paquets natifs de la distribution sont utilisés par défaut sur chaque plateforme testée. Les fichiers de dépôts externes existants ne sont pas supprimés, et le rôle ne migre pas un serveur installé entre différentes sources de paquets ou versions majeures. Vérifiez les conflits du gestionnaire de paquets avant de migrer une installation externe existante.

Le parcours de dépôt externe est une option explicite et non testée activable via `mariadb_configure_repo: true`. Son ancien sélecteur `mariadb_version` ne correspond pas à une version de serveur natif ni à une recommandation pour une version amont prise en charge. Les anciens miroirs codés en dur ne couvrent pas toutes les distributions actuelles ; utilisez la configuration native par défaut ou qualifiez d'abord indépendamment la configuration du dépôt.

Le rôle détecte la version du serveur en cours d'exécution ainsi que son répertoire de données avant d'écrire la configuration. Cela préserve `/var/lib/mariadb` sous Ubuntu 26.04 ainsi que le stockage de base de données existant. Un paramètre `mariadb_data_dir` explicite en conflit provoque un échec indiquant la nécessité d'une migration ; le rôle ne déplace pas les données. Les surcharges publiques des paquets, du service, du socket et des fichiers de configuration restent disponibles.

Les changements de mot de passe utilisent des requêtes paramétrées afin que MariaDB puisse appliquer son plugin strict de validation des mots de passe. Le fichier client privé de root utilise le socket Unix local. Les comptes inchangés conservent leurs privilèges et leurs mots de passe.

## Développement et tests

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Ces cibles sont définies dans le [Makefile](../../../Makefile). Molecule nécessite son pilote et ses dépendances de test. Les cibles Docker utilisent les fichiers présents sous [dev](../../../dev) ; `make docker-test` est la cible Docker de base, et non `make test-docker`.

## Documentation, sécurité et licence

- [Exemples de configuration](../../../docs/README.md)
- [Contribuer](../../../CONTRIBUTING.md)
- [Politique de sécurité](../../../SECURITY.md)
- [Licence MIT](../../../LICENSE)
