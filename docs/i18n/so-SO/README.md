<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Soomaali** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · **Soomaali** · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Doorka Ansible ee MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Door Ansible ah oo loogu talagalay rakibidda MariaDB, diyaarinta kaydadka xogta iyo isticmaalayaasha, iyo habaynta hawlaha ikhtiyaariga ah ee nuqul-kaydinta iyo kormeerka. Doorku wuxuu kala soocaa rakibidda, habaynta, xaqiijinta, iyo hawlaha hawlgalka si mid kasta si madax-bannaan dib loogu eegi karo.

## Awoodaha

| Aag | Hirgelinta |
| --- | --- |
| Rakibidda iyo habaynta | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml), iyo qaab-dhismeedyada habaynta |
| Xaqiijinta gelinta iyo dejinta akoonnada | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Diyaarinta kaydka xogta | [databases.yml](../../../tasks/databases.yml) |
| Dejinta nuqul-samaynta (replication) | [replication.yml](../../../tasks/replication.yml) wuxuu dejiyaa aqoonsiyada server-ka iyo dejinta diiwaanka binary-ga/isticmaalaha ee dhinaca koowaad |
| Nuqul-kaydinno jadwalsan | [backup.yml](../../../tasks/backup.yml) iyo [qaab-dhismeedka qoraalka nuqul-kaydinta](../../../templates/mariadb_backup.sh.j2) |
| Kormeerka | [monitoring.yml](../../../tasks/monitoring.yml) iyo qaab-dhismeedyada dhoofiyaha/hubinta |

Hawlaha nuqul-samaynta (replication) ee kaydkan ku jira ma hirgeliyaan u-wareegid toos ah marka fashil dhaco (failover) ama bilow dhammaystiran oo nuqul ah. Dhacdooyinka badan ee Molecule waa qaab-dhismeed tijaabo ah, ma aha caddayn gayn dhacdooyin badan oo hal martigeliye ah. Dib u eeg sir-qorista nuqul-kaydinta, hab-dhaqanka soo-celinta, iyo iswaafaqsanaanta nooca kaydka xogta ee gayntaada; README-gani ma dammaanad qaadayo.

## Rakibidda iyo isticmaalka

```bash
ansible-galaxy role install git+https://github.com/somethingwithproof/ansible-role-mariadb.git
ansible-galaxy collection install community.mysql
```

```yaml
# inventory.yml
database_servers:
  hosts:
    db01:
      ansible_host: "192.168.0.10"
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

Ku bixi doorsoomayaasha erayga sirta ah ee la tixraacay iyadoo loo marayo Ansible Vault ama nidaamkaaga maamulka siraha. Isticmaal [defaults/main.yml](../../../defaults/main.yml) si aad u hesho magacyada ikhtiyaarrada dhabta ah iyo qiimayaasha caadiga ah.

## Shuruudaha iyo iswaafaqsanaanta

Koontaroolaha hadda jira waa Ansible 14.5.0 / ansible-core 2.21.5 oo wata Python 3.13. Xaaladda `lts` waxay tijaabisaa xirmooyinka qaybinta asalka ah ee ku jira Ubuntu 22.04, 24.04 iyo 26.04, Debian 12 iyo 13, iyo Rocky Linux 9 iyo 10. Magacyada kale ee EL ee ku jira xogta-hoose ma xaqiijinayaan shahaado gooni ah oo RHEL ama AlmaLinux ah.

Xirmooyinka qaybinta asalka ah ayaa ah doorashada caadiga ah madal kasta oo la tijaabiyay. Faylasha kaydka dibadda ee hore u jiray lama saaro, doorkuna ma u raro server horay u rakibnaa inta u dhaxaysa ilaha xirmooyinka ama noocyada waaweyn. Dib u eeg iska-horimaadyada maamulaha xirmooyinka ka hor inta aanad rarin rakibid dibadda ah oo hore u jirtay.

Marinka kaydka dibaddu waa doorasho cad oo aan la tijaabin oo lagu hawlgeliyo `mariadb_configure_repo: true`. Xulaha hore ee `mariadb_version` ma aha nooc server asal ah ama talo-bixin sii-dayn sare (upstream) oo la taageero. Muraayadaha (mirrors) duugga ah ee koodhka ku dhex qoran ma daboolaan qaybin kasta oo hadda jirta; isticmaal doorashada asalka ah ama marka hore si madax-bannaan u xaqiiji habaynta kaydka.

Doorku wuxuu ogaadaa nooca server-ka shaqaynaya iyo galka xogta ka hor inta aanu qorin habaynta. Tani waxay ilaalisaa `/var/lib/mariadb` ee Ubuntu 26.04 iyo kaydinta xogta ee hore u jirtay. `mariadb_data_dir` cad oo iska hor imanaya wuxuu ku fashilmaa shuruud raris; doorku ma dhaqaajiyo xogta. Beddelka xirmada dadweynaha, adeegga, socket-ka, iyo faylka habayntu way sii furan yihiin.

Isbeddellada erayga sirta ahi waxay adeegsadaan bayaanno cabbiraysan (parameterized statements) si MariaDB u hirgeliyo plugin-kiisa adag ee xaqiijinta erayga sirta ah. Faylka macmiilka gaarka ah ee root wuxuu adeegsadaa Unix socket-ka maxalliga ah. Akoonnada aan la beddelin waxay haystaan xuquuqdooda iyo erayadooda sirta ah.

## Horumarinta iyo tijaabinta

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Bartilmaameedyadan waxaa lagu qeexay [Makefile](../../../Makefile). Molecule wuxuu u baahan yahay darawalkiisa iyo ku-tiirsanaanta tijaabada. Bartilmaameedyada Docker waxay adeegsadaan faylasha ku hoos jira [dev](../../../dev); `make docker-test` waa bartilmaameedka aasaasiga ah ee Docker, ma aha `make test-docker`.

## Dukumeentiyada, amniga, iyo shatiga

- [Tusaalooyinka habaynta](../../../docs/README.md)
- [Ka qaybqaadashada](../../../CONTRIBUTING.md)
- [Siyaasadda amniga](../../../SECURITY.md)
- [Shatiga MIT](../../../LICENSE)
