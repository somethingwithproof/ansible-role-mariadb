<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Yorùbá** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · **Yorùbá** · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Ipa Ansible MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Ipa Ansible kan fún fífi MariaDB sórí ẹ̀rọ, ìpèsè àwọn ibi-ìpamọ́ dátà àti àwọn olùmúlò, àti ṣíṣètò àwọn iṣẹ́ àdàkọ ààbò àti àbójútó àṣàyàn. Ipa náà ya ìfisílẹ̀, ìṣètò, ìjẹ́rìísí, àti àwọn iṣẹ́ ìṣiṣẹ́ sọ́tọ̀ kí a lè ṣàyẹ̀wò ọ̀kọ̀ọ̀kan ní òmìnira.

## Àwọn agbára

| Agbègbè | Ìmúṣẹ |
| --- | --- |
| Ìfisílẹ̀ àti ìṣètò | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml), àti àwọn àwòkọ́ṣe ìṣètò |
| Ìjẹ́rìísí ìtẹ̀wọlé àti ìṣètò àkántì | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Ìpèsè ibi-ìpamọ́ dátà | [databases.yml](../../../tasks/databases.yml) |
| Àwọn ètò ìṣàdàkọ-dátà | [replication.yml](../../../tasks/replication.yml) ń ṣètò àwọn ID ẹ̀rọ-ìpèsè àti àwọn ètò àkọsílẹ̀ báínárì/olùmúlò ti apá àkọ́kọ́ |
| Àwọn àdàkọ ààbò tí a ṣètò àkókò fún | [backup.yml](../../../tasks/backup.yml) àti [àwòkọ́ṣe ìwé-àṣẹ àdàkọ ààbò](../../../templates/mariadb_backup.sh.j2) |
| Àbójútó | [monitoring.yml](../../../tasks/monitoring.yml) àti àwọn àwòkọ́ṣe olùkójáde/ìṣàyẹ̀wò |

Àwọn iṣẹ́ ìṣàdàkọ-dátà tí a fi sí ibi-ìpamọ́ kò ṣe ìmúṣẹ ìyípadà-àìdáwọ́dúró aládàáṣe tàbí ìbẹ̀rẹ̀pẹ̀pẹ̀ ẹ̀dà-àdàkọ pípé. Ọ̀pọ̀lọpọ̀ àpẹẹrẹ Molecule jẹ́ ìṣètò ìdánwò, kì í ṣe ẹ̀rí ìgbékalẹ̀ ọ̀pọ̀-àpẹẹrẹ lórí ẹ̀rọ olùgbàlejò kan ṣoṣo. Ṣàyẹ̀wò ìfipamọ́-ìkọ̀kọ̀ àdàkọ ààbò, ìwà ìdápadà, àti ìbáramu ẹ̀yà ibi-ìpamọ́ dátà fún ìgbékalẹ̀ rẹ; README yìí kò ṣe ìdánilójú wọn.

## Ìfisílẹ̀ àti ìlò

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

Pèsè àwọn oníyípadà ọ̀rọ̀-ìgbaniwọlé tí a tọ́ka sí nípasẹ̀ Ansible Vault tàbí ètò ìṣàkóso àṣírí rẹ. Lo [defaults/main.yml](../../../defaults/main.yml) fún àwọn orúkọ àṣàyàn gidi àti àwọn àṣàyàn àkọ́kọ́.

## Àwọn ohun-ìbéèrè àti ìbáramu

Olùṣàkóso lọ́wọ́lọ́wọ́ ni Ansible 14.5.0 / ansible-core 2.21.5 pẹ̀lú Python 3.13. Ìṣẹ̀lẹ̀ `lts` ń dán àwọn àpò ìpínkiri abínibí wò lórí Ubuntu 22.04, 24.04 àti 26.04, Debian 12 àti 13, àti Rocky Linux 9 àti 10. Àwọn orúkọ-ìtọ́kasí EL nínú dátà-àpèjúwe kò fìdí ìwé-ẹ̀rí RHEL tàbí AlmaLinux lọ́tọ̀ múlẹ̀.

Àwọn àpò ìpínkiri abínibí ni àṣàyàn àkọ́kọ́ lórí gbogbo pẹpẹ tí a dán wò. A kò yọ àwọn fáìlì ibi-ìpamọ́ ìta tí ó wà tẹ́lẹ̀ kúrò, ipa náà kò sì ṣe ìṣíkiri ẹ̀rọ-ìpèsè tí a ti fi sórí ẹ̀rọ láàárín àwọn orísun àpò tàbí àwọn ẹ̀yà pàtàkì. Ṣàyẹ̀wò àwọn ìkọlù olùṣàkóso àpò ṣáájú ṣíṣe ìṣíkiri ìfisílẹ̀ ìta tí ó wà tẹ́lẹ̀.

Ọ̀nà ibi-ìpamọ́ ìta jẹ́ àṣàyàn pàtó tí a kò tíì dán wò nípasẹ̀ `mariadb_configure_repo: true`. Olùyàn `mariadb_version` àtijọ́ rẹ̀ kì í ṣe ẹ̀yà ẹ̀rọ-ìpèsè abínibí tàbí àbá fún ìtújáde orísun-òkè tí a ṣètìlẹ́yìn fún. Àwọn dígí àtijọ́ tí a kọ sínú kóòdù kò bo gbogbo ìpínkiri lọ́wọ́lọ́wọ́; lo àṣàyàn àkọ́kọ́ abínibí tàbí jẹ́rìísí ìṣètò ibi-ìpamọ́ náà lọ́tọ̀ ní àkọ́kọ́.

Ipa náà máa ń ṣàwárí ẹ̀yà ẹ̀rọ-ìpèsè tí ń ṣiṣẹ́ àti fódà dátà rẹ̀ ṣáájú kíkọ ìṣètò. Èyí pa `/var/lib/mariadb` ti Ubuntu 26.04 àti ibi-ìpamọ́ dátà tí ó wà tẹ́lẹ̀ mọ́. `mariadb_data_dir` pàtó tí ó ta kò ó yóò kùnà pẹ̀lú ìbéèrè ìṣíkiri; ipa náà kì í gbé dátà lọ sí ibòmíràn. Àwọn àyípadà àpò, iṣẹ́-ìpèsè, sọ́kẹ́ẹ̀tì, àti fáìlì ìṣètò fún gbogbo ènìyàn ṣì wà ní àrọ́wọ́tó.

Àwọn àyípadà ọ̀rọ̀-ìgbaniwọlé ń lo àwọn gbólóhùn tí a pèsè pàrámítà fún kí MariaDB lè mú àfikún ìjẹ́rìísí ọ̀rọ̀-ìgbaniwọlé líle rẹ̀ ṣiṣẹ́. Fáìlì oníbàárà àdáni ti root ń lo sọ́kẹ́ẹ̀tì Unix abẹ́lé. Àwọn àkántì tí kò yípadà máa ń pa àwọn àṣẹ àti ọ̀rọ̀-ìgbaniwọlé wọn mọ́.

## Ìdàgbàsókè àti ìdánwò

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

A ṣàlàyé àwọn ìfojúsùn wọ̀nyí nínú [Makefile](../../../Makefile). Molecule nílò awakọ̀ rẹ̀ àti àwọn ìgbẹ́kẹ̀lé ìdánwò. Àwọn ìfojúsùn Docker ń lo àwọn fáìlì lábẹ́ [dev](../../../dev); `make docker-test` ni ìfojúsùn Docker ìpìlẹ̀, kì í ṣe `make test-docker`.

## Ìwé-àkọsílẹ̀, ààbò, àti ìwé-àṣẹ

- [Àwọn àpẹẹrẹ ìṣètò](../../../docs/README.md)
- [Ìkópa](../../../CONTRIBUTING.md)
- [Ìlànà ààbò](../../../SECURITY.md)
- [Ìwé-àṣẹ MIT](../../../LICENSE)
