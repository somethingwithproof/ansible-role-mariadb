<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Bahasa Indonesia** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · **Bahasa Indonesia**
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Peran Ansible MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Peran Ansible untuk memasang MariaDB, menyediakan basis data dan pengguna, serta mengonfigurasi tugas pencadangan dan pemantauan opsional. Peran ini memisahkan tugas pemasangan, konfigurasi, validasi, dan operasional agar masing-masing dapat ditinjau secara independen.

## Kemampuan

| Area | Implementasi |
| --- | --- |
| Pemasangan dan konfigurasi | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml), dan templat konfigurasi |
| Validasi masukan dan penyiapan akun | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Penyediaan basis data | [databases.yml](../../../tasks/databases.yml) |
| Pengaturan replikasi | [replication.yml](../../../tasks/replication.yml) mengatur ID server serta pengaturan binary logging dan pengguna di sisi primer |
| Pencadangan terjadwal | [backup.yml](../../../tasks/backup.yml) dan [templat skrip pencadangan](../../../templates/mariadb_backup.sh.j2) |
| Pemantauan | [monitoring.yml](../../../tasks/monitoring.yml) serta templat exporter/pemeriksaan |

Tugas replikasi yang disertakan tidak mengimplementasikan failover otomatis atau inisialisasi replika lengkap. Beberapa instans Molecule merupakan topologi pengujian, bukan bukti penerapan multi-instans pada satu host. Tinjau enkripsi cadangan, perilaku pemulihan, dan kompatibilitas versi basis data untuk penerapan Anda; hal-hal tersebut tidak dijamin oleh README ini.

## Pemasangan dan penggunaan

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

Sediakan variabel kata sandi yang dirujuk melalui Ansible Vault atau sistem manajemen rahasia Anda. Gunakan [defaults/main.yml](../../../defaults/main.yml) untuk nama opsi dan nilai default yang sebenarnya.

## Persyaratan dan kompatibilitas

Controller saat ini menggunakan Ansible 14.5.0 / ansible-core 2.21.5 dengan Python
3.13. Skenario `lts` menguji paket distribusi asli pada Ubuntu
22.04, 24.04, dan 26.04, Debian 12 dan 13, serta Rocky Linux 9 dan 10. Alias EL
pada metadata tidak menunjukkan sertifikasi RHEL atau AlmaLinux secara terpisah.

Paket distribusi asli menjadi pilihan default di setiap platform yang diuji.
Berkas repositori eksternal yang sudah ada tidak dihapus, dan peran ini tidak
memigrasikan server terpasang antar sumber paket atau antar versi mayor. Tinjau
konflik pengelola paket sebelum memigrasikan instalasi eksternal yang sudah ada.

Jalur repositori eksternal bersifat opsional eksplisit yang belum diuji melalui
`mariadb_configure_repo: true`. Pemilih `mariadb_version` lama bukanlah
versi server asli maupun rekomendasi rilis hulu yang didukung.
Mirror lama yang ditulis secara statis tidak mencakup setiap distribusi saat ini; gunakan
paket bawaan distribusi atau uji konfigurasi repositori secara independen terlebih dahulu.

Peran ini mendeteksi versi dan direktori data server yang berjalan sebelum
menulis konfigurasi. Hal ini mempertahankan `/var/lib/mariadb` pada Ubuntu 26.04 dan
penyimpanan basis data yang sudah ada. Nilai `mariadb_data_dir` eksplisit yang bertentangan akan gagal
dengan persyaratan migrasi; peran ini tidak memindahkan data. Penimpaan publik untuk paket,
layanan, soket, dan berkas konfigurasi tetap tersedia.

Perubahan kata sandi menggunakan pernyataan berparameter agar MariaDB dapat menerapkan
plugin validasi kata sandi ketatnya. Berkas klien privat milik root menggunakan
soket Unix lokal. Akun yang tidak berubah tetap mempertahankan hak akses dan kata sandinya.

## Pengembangan dan pengujian

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Target-target ini didefinisikan dalam [Makefile](../../../Makefile). Molecule memerlukan driver dan dependensi pengujiannya. Target Docker menggunakan berkas di bawah [dev](../../../dev); `make docker-test` adalah target Docker dasar, bukan `make test-docker`.

## Dokumentasi, keamanan, dan lisensi

- [Contoh konfigurasi](../../../docs/README.md)
- [Berkontribusi](../../../CONTRIBUTING.md)
- [Kebijakan keamanan](../../../SECURITY.md)
- [Lisensi MIT](../../../LICENSE)
