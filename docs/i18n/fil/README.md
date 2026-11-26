<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Filipino** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · **Filipino**

</details>
<!-- translations:end -->

# MariaDB Ansible Role

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Isang Ansible role para sa pag-install ng MariaDB, pag-provision ng mga database at user, at pag-configure ng mga opsyonal na gawain para sa backup at monitoring. Pinaghihiwalay ng role ang pag-install, pag-configure, pagpapatunay, at mga gawaing pang-operasyon upang masuri ang bawat isa nang nakapag-iisa.

## Mga kakayahan

| Larangan | Implementasyon |
| --- | --- |
| Pag-install at pag-configure | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml), at mga template ng konfigurasyon |
| Pagpapatunay ng input at pag-setup ng account | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Pag-provision ng database | [databases.yml](../../../tasks/databases.yml) |
| Mga setting ng replication | Itinatakda ng [replication.yml](../../../tasks/replication.yml) ang mga server ID at mga setting ng binary logging/user sa panig ng primary |
| Mga nakaiskedyul na backup | [backup.yml](../../../tasks/backup.yml) at ang [template ng backup script](../../../templates/mariadb_backup.sh.j2) |
| Monitoring | [monitoring.yml](../../../tasks/monitoring.yml) at mga template ng exporter/check |

Ang mga naka-check-in na gawain sa replication ay hindi nagpapatupad ng awtomatikong failover o kumpletong pag-initialize ng replica. Ang maramihang instance ng Molecule ay isang test topology, hindi ebidensya ng multi-instance deployment sa isang host. Suriin ang pag-encrypt ng backup, gawi sa pag-restore, at pagiging tugma ng bersyon ng database para sa iyong deployment; hindi ginagarantiyahan ang mga ito ng README na ito.

## Pag-install at paggamit

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

Ibigay ang mga tinutukoy na variable ng password sa pamamagitan ng Ansible Vault o ng iyong secret-management system. Gamitin ang [defaults/main.yml](../../../defaults/main.yml) para sa mga aktwal na pangalan ng opsyon at mga default.

## Mga kinakailangan at pagiging tugma

Ang kasalukuyang controller ay Ansible 14.5.0 / ansible-core 2.21.5 na may Python
3.13. Sinusubukan ng senaryong `lts` ang mga native na package ng distribusyon sa Ubuntu
22.04, 24.04 at 26.04, Debian 12 at 13, at Rocky Linux 9 at 10. Ang mga alias ng EL
sa metadata ay hindi nagpapatunay ng hiwalay na sertipikasyon sa RHEL o AlmaLinux.

Ang mga native na package ng distribusyon ang default sa bawat sinubukang platform.
Hindi tinatanggal ang mga umiiral na panlabas na repository file, at hindi
inililipat ng role ang naka-install na server sa pagitan ng mga pinagmulan ng package o pangunahing bersyon. Suriin
ang mga salungatan sa package manager bago mag-migrate ng umiiral na panlabas na pag-install.

Ang path ng panlabas na repository ay isang tahasan at hindi pa nasusubukang opt-in sa pamamagitan ng
`mariadb_configure_repo: true`. Ang legacy nitong tagapili na `mariadb_version` ay hindi isang
bersyon ng native server o rekomendasyon para sa sinusuportahang upstream release.
Hindi saklaw ng mga lumang hard-coded na mirror ang bawat kasalukuyang distribusyon; gamitin ang
native na default o sariling beripikahin muna ang konfigurasyon ng repository.

Tinutuklas ng role ang bersyon at data directory ng tumatakbong server bago
magsulat ng konfigurasyon. Pinananatili nito ang `/var/lib/mariadb` ng Ubuntu 26.04 at ang
umiiral na storage ng database. Ang tahasang sumasalungat na `mariadb_data_dir` ay nabibigo
nang may kinakailangan sa pag-migrate; hindi inililipat ng role ang datos. Nananatiling magagamit ang mga pampublikong override para sa package,
serbisyo, socket, at configuration file.

Gumagamit ang mga pagbabago ng password ng mga parameterized statement upang maipatupad ng MariaDB ang
mahigpit nitong plugin sa pagpapatunay ng password. Gumagamit ang pribadong client file ng root ng lokal na
Unix socket. Pinananatili ng mga hindi nabagong account ang kanilang mga grant at password.

## Pag-develop at pagsusuri

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Tinutukoy ang mga target na ito sa [Makefile](../../../Makefile). Kinakailangan ng Molecule ang driver at mga test dependency nito. Gumagamit ang mga target ng Docker ng mga file sa ilalim ng [dev](../../../dev); ang `make docker-test` ang pangunahing target ng Docker, hindi ang `make test-docker`.

## Dokumentasyon, seguridad, at lisensya

- [Mga halimbawa ng konfigurasyon](../../../docs/README.md)
- [Pag-aambag](../../../CONTRIBUTING.md)
- [Patakaran sa seguridad](../../../SECURITY.md)
- [Lisensyang MIT](../../../LICENSE)
