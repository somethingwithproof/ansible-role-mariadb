<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Bahasa Melayu** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · **Bahasa Melayu** · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Peranan Ansible MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Peranan Ansible untuk memasang MariaDB, memperuntukkan pangkalan data dan pengguna, serta mengkonfigurasikan tugas sandaran dan pemantauan pilihan. Peranan ini mengasingkan tugas pemasangan, konfigurasi, pengesahan, dan operasi supaya setiap satunya boleh disemak secara berasingan.

## Keupayaan

| Bidang | Pelaksanaan |
| --- | --- |
| Pemasangan dan konfigurasi | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml), dan templat konfigurasi |
| Pengesahan input dan persediaan akaun | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Peruntukan pangkalan data | [databases.yml](../../../tasks/databases.yml) |
| Tetapan replikasi | [replication.yml](../../../tasks/replication.yml) menetapkan ID pelayan serta tetapan pengelogan binari/pengguna pihak utama |
| Sandaran berjadual | [backup.yml](../../../tasks/backup.yml) dan [templat skrip sandaran](../../../templates/mariadb_backup.sh.j2) |
| Pemantauan | [monitoring.yml](../../../tasks/monitoring.yml) serta templat pengeksport/semakan |

Tugas replikasi yang disertakan tidak melaksanakan gagal alih automatik atau pemulaan replika yang lengkap. Berbilang tika Molecule ialah topologi ujian, bukannya bukti pengerahan berbilang tika pada satu hos. Semak penyulitan sandaran, tingkah laku pemulihan, dan keserasian versi pangkalan data untuk pengerahan anda; perkara tersebut tidak dijamin oleh README ini.

## Pemasangan dan penggunaan

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

Sediakan pemboleh ubah kata laluan yang dirujuk melalui Ansible Vault atau sistem pengurusan rahsia anda. Gunakan [defaults/main.yml](../../../defaults/main.yml) untuk nama pilihan sebenar dan nilai lalainya.

## Keperluan dan keserasian

Pengawal semasa ialah Ansible 14.5.0 / ansible-core 2.21.5 dengan Python 3.13. Senario `lts` menguji pakej pengedaran asli pada Ubuntu 22.04, 24.04 dan 26.04, Debian 12 dan 13, serta Rocky Linux 9 dan 10. Alias EL dalam metadata tidak membuktikan pensijilan RHEL atau AlmaLinux secara berasingan.

Pakej pengedaran asli ialah pilihan lalai pada setiap platform yang diuji. Fail repositori luaran sedia ada tidak dibuang, dan peranan ini tidak memigrasikan pelayan yang telah dipasang antara sumber pakej atau versi utama. Semak konflik pengurus pakej sebelum memigrasikan pemasangan luaran sedia ada.

Laluan repositori luaran ialah pilihan ikut serta eksplisit yang tidak diuji melalui `mariadb_configure_repo: true`. Pemilih legasi `mariadb_version` bukanlah versi pelayan asli atau cadangan untuk keluaran huluan yang disokong. Cermin berkod keras yang lama tidak merangkumi setiap pengedaran semasa; gunakan pilihan lalai asli atau tentusahkan konfigurasi repositori secara berasingan terlebih dahulu.

Peranan ini mengenal pasti versi pelayan yang sedang berjalan dan direktori datanya sebelum menulis konfigurasi. Ini mengekalkan `/var/lib/mariadb` pada Ubuntu 26.04 serta storan pangkalan data sedia ada. `mariadb_data_dir` eksplisit yang bercanggah akan gagal dengan keperluan migrasi; peranan ini tidak memindahkan data. Penggantian awam bagi pakej, perkhidmatan, soket dan fail konfigurasi kekal tersedia.

Pertukaran kata laluan menggunakan penyataan berparameter supaya MariaDB dapat menguatkuasakan pemalam pengesahan kata laluan ketatnya. Fail klien peribadi bagi root menggunakan soket Unix tempatan. Akaun yang tidak diubah mengekalkan hak akses dan kata laluannya.

## Pembangunan dan pengujian

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Sasaran ini ditakrifkan dalam [Makefile](../../../Makefile). Molecule memerlukan pemacu dan kebergantungan ujiannya. Sasaran Docker menggunakan fail di bawah [dev](../../../dev); `make docker-test` ialah sasaran Docker asas, bukannya `make test-docker`.

## Dokumentasi, keselamatan, dan lesen

- [Contoh konfigurasi](../../../docs/README.md)
- [Menyumbang](../../../CONTRIBUTING.md)
- [Dasar keselamatan](../../../SECURITY.md)
- [Lesen MIT](../../../LICENSE)
