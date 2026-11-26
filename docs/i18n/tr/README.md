<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Türkçe** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · **Türkçe** · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# MariaDB Ansible Rolü

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

MariaDB kurulumu, veritabanı ve kullanıcı oluşturma ile isteğe bağlı yedekleme ve izleme görevlerini yapılandırmak için bir Ansible rolü. Rol; kurulum, yapılandırma, doğrulama ve operasyonel görevleri birbirinden ayırarak her birinin bağımsız olarak incelenebilmesini sağlar.

## Yetenekler

| Alan | Uygulama |
| --- | --- |
| Kurulum ve yapılandırma | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml) ve yapılandırma şablonları |
| Girdi doğrulama ve hesap kurulumu | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Veritabanı oluşturma | [databases.yml](../../../tasks/databases.yml) |
| Çoğaltma ayarları | [replication.yml](../../../tasks/replication.yml) sunucu kimliklerini ve birincil taraf ikili günlükleme/kullanıcı ayarlarını yapılandırır |
| Zamanlanmış yedeklemeler | [backup.yml](../../../tasks/backup.yml) ve [yedekleme betiği şablonu](../../../templates/mariadb_backup.sh.j2) |
| İzleme | [monitoring.yml](../../../tasks/monitoring.yml) ve dışa aktarıcı/kontrol şablonları |

Depodaki çoğaltma görevleri otomatik yük devretme veya tam replika başlatma işlemlerini uygulamaz. Birden fazla Molecule örneği bir test topolojisidir; tek bir ana bilgisayarda çoklu örnek dağıtımının kanıtı değildir. Dağıtımınız için yedekleme şifrelemesini, geri yükleme davranışını ve veritabanı sürüm uyumluluğunu inceleyin; bunlar bu README tarafından garanti edilmez.

## Kurulum ve kullanım

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

Başvurulan parola değişkenlerini Ansible Vault veya gizli bilgi yönetim sisteminiz aracılığıyla sağlayın. Gerçek seçenek adları ve varsayılan değerler için [defaults/main.yml](../../../defaults/main.yml) dosyasına bakın.

## Gereksinimler ve uyumluluk

Mevcut denetleyici Python 3.13 ile Ansible 14.5.0 / ansible-core 2.21.5 sürümüdür. `lts` senaryosu Ubuntu 22.04, 24.04 ve 26.04, Debian 12 ve 13 ile Rocky Linux 9 ve 10 üzerindeki yerel dağıtım paketlerini test eder. Üst verilerdeki EL takma adları ayrı bir RHEL veya AlmaLinux sertifikasyonu sağlamaz.

Test edilen her platformda yerel dağıtım paketleri varsayılandır. Mevcut harici depo dosyaları kaldırılmaz ve rol, kurulu bir sunucuyu paket kaynakları veya ana sürümler arasında geçirmez. Mevcut bir harici kurulumu geçirmeden önce paket yöneticisi çakışmalarını inceleyin.

Harici depo yolu, `mariadb_configure_repo: true` aracılığıyla açık ve test edilmemiş bir tercihtir. Eski `mariadb_version` seçicisi bir yerel sunucu sürümü veya desteklenen bir yukarı akış sürümü için öneri değildir. Eski sabit kodlanmış yansılar mevcut her dağıtımı kapsamaz; yerel varsayılanı kullanın veya önce depo yapılandırmasını bağımsız olarak doğrulayın.

Rol, yapılandırmayı yazmadan önce çalışan sunucunun sürümünü ve veri dizinini keşfeder. Bu işlem Ubuntu 26.04'ün `/var/lib/mariadb` dizinini ve mevcut veritabanı depolama alanını korur. Çakışan açık bir `mariadb_data_dir` değeri bir geçiş gereksinimi hatasıyla başarısız olur; rol verileri taşımaz. Genel paket, servis, soket ve yapılandırma dosyası geçersiz kılmaları kullanılabilir durumdadır.

Parola değişiklikleri, MariaDB'nin katı parola doğrulama eklentisini uygulayabilmesi için parametreli ifadeler kullanır. Root kullanıcısının özel istemci dosyası yerel Unix soketini kullanır. Değiştirilmeyen hesaplar yetkilerini ve parolalarını korur.

## Geliştirme ve test

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Bu hedefler [Makefile](../../../Makefile) dosyasında tanımlanmıştır. Molecule kendi sürücüsünü ve test bağımlılıklarını gerektirir. Docker hedefleri [dev](../../../dev) altındaki dosyaları kullanır; temel Docker hedefi `make test-docker` değil, `make docker-test` hedefidir.

## Belgelendirme, güvenlik ve lisans

- [Yapılandırma örnekleri](../../../docs/README.md)
- [Katkıda bulunma](../../../CONTRIBUTING.md)
- [Güvenlik politikası](../../../SECURITY.md)
- [MIT lisansı](../../../LICENSE)
