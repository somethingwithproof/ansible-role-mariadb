<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Igbo** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · **Igbo** · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Ọrụ Ansible nke MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Ọrụ Ansible maka ịwụnye MariaDB, ịkwado nchekwa data na ndị ọrụ, na ịhazi ọrụ nchekwa ndabere na nlekọta nhọrọ. Ọrụ a na-ekewapụ nwụnye, nhazi, nnyocha, na ọrụ arụmọrụ ka e wee nwee ike ilele nke ọ bụla n'iche n'iche.

## Ikike ọrụ

| Mpaghara | Mmejupụta |
| --- | --- |
| Nwụnye na nhazi | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml), na ndebiri nhazi |
| Nnyocha ntinye na nhazi akaụntụ | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Nkwado nchekwa data | [databases.yml](../../../tasks/databases.yml) |
| Ntọala replication | [replication.yml](../../../tasks/replication.yml) na-atọ ID sava na ntọala binary logging/onye ọrụ n'akụkụ isi |
| Nchekwa ndabere a haziri oge | [backup.yml](../../../tasks/backup.yml) na [ndebiri skriptị nchekwa ndabere](../../../templates/mariadb_backup.sh.j2) |
| Nlekọta | [monitoring.yml](../../../tasks/monitoring.yml) na ndebiri exporter/nnyocha |

Ọrụ replication e debanyere anaghị emejupụta mgbanwe ọdịda n'akpaghị aka ma ọ bụ mmalite replica zuru oke. Ọtụtụ instance Molecule bụ nhazi nnwale, ọ bụghị ihe akaebe nke ntinye ọtụtụ instance n'otu host. Lelee nzochi nchekwa ndabere, omume iweghachi, na ndakọrịta ụdị nchekwa data maka ntinye n'ọrụ gị; README a anaghị ekwe nkwa ha.

## Nwụnye na ojiji

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

Nye variable okwuntughe ndị e zoro aka na ha site na Ansible Vault ma ọ bụ usoro njikwa ihe nzuzo gị. Jiri [defaults/main.yml](../../../defaults/main.yml) maka aha nhọrọ na ntọala ndabara n'ezie.

## Ihe ndị a chọrọ na ndakọrịta

Controller dị ugbu a bụ Ansible 14.5.0 / ansible-core 2.21.5 nwere Python
3.13. Ọnọdụ `lts` na-anwale ngwugwu nkesa nke sistemụ na Ubuntu
22.04, 24.04 na 26.04, Debian 12 na 13, yana Rocky Linux 9 na 10. Aha ndị ọzọ nke EL
dị na metadata egosighị asambodo dị iche maka RHEL ma ọ bụ AlmaLinux.

Ngwugwu nkesa nke sistemụ bụ ndabara na ikpo okwu ọ bụla a nwalere.
A naghị ewepụ faịlụ ebe nchekwa mpụga dịbu, ma ọrụ ahụ anaghị
ebufe sava a wụnyere n'etiti isi mmalite ngwugwu ma ọ bụ ụdị ukwu. Lelee
esemokwu nke njikwa ngwugwu tupu ibufe nwụnye mpụga dịbu.

Ụzọ ebe nchekwa mpụga bụ nhọrọ doro anya nke a na-anwalebeghị site na
`mariadb_configure_repo: true`. Nhọrọ ochie ya bụ `mariadb_version` abụghị
ụdị sava nke sistemụ ma ọ bụ ndụmọdụ maka ntọhapụ upstream a kwadoro.
Mirror ochie e dere n'ime koodu anaghị ekpuchi nkesa ọ bụla dị ugbu a; jiri
ndabara nke sistemụ ma ọ bụ buru ụzọ nyochaa nhazi ebe nchekwa ahụ n'onwe gị.

Ọrụ ahụ na-achọpụta ụdị sava na-agba ọsọ na folda data ya tupu
ide nhazi. Nke a na-echekwa `/var/lib/mariadb` nke Ubuntu 26.04 na
nchekwa data dịbu. `mariadb_data_dir` doro anya nke na-emegiderịta onwe ya na-ada
ma chọọ mbufe data; ọrụ ahụ anaghị ebufe data. Ngbanwe ọha nke ngwugwu,
ọrụ usoro, socket na faịlụ nhazi ka dị.

Mgbanwe okwuntughe na-eji nkwupụta nwere parameter ka MariaDB wee nwee ike itinye
plugin nnyocha okwuntughe siri ike ya n'ọrụ. Faịlụ client nzuzo nke root na-eji
Unix socket dị n'ime. Akaụntụ ndị na-agbanwebeghị na-edobe ikike na okwuntughe ha.

## Mmepe na nnwale

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

A kọwara ebumnuche ndị a na [Makefile](../../../Makefile). Molecule chọrọ driver ya na ndabere nnwale ya. Ebumnuche Docker na-eji faịlụ dị n'okpuru [dev](../../../dev); `make docker-test` bụ isi ebumnuche Docker, ọ bụghị `make test-docker`.

## Akwụkwọ nkọwa, nchekwa, na ikikere

- [Ihe atụ nhazi](../../../docs/README.md)
- [Itinye aka](../../../CONTRIBUTING.md)
- [Atụmatụ nchekwa](../../../SECURITY.md)
- [Ikikere MIT](../../../LICENSE)
