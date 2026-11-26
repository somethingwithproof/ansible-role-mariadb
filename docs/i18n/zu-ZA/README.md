<!-- translations:start -->
**Languages:** [English](../../../README.md) · **isiZulu** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · **isiZulu**
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Indima ye-Ansible ye-MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Indima (role) ye-Ansible yokufaka i-MariaDB, ukuhlinzeka ngezizindalwazi nabasebenzisi, nokulungiselela imisebenzi yokwenza ikhophi eyisipele nokuqapha ezikhethelayo. Le ndima ihlukanisa imisebenzi yokufaka, ukulungiselela, ukuqinisekisa, nokusebenza ukuze umsebenzi ngamunye ubuyekezwe ngokuzimela.

## Amandla okusebenza

| Indawo | Ukusebenza |
| --- | --- |
| Ukufaka nokulungiselela | I-[install.yml](../../../tasks/install.yml), i-[configure.yml](../../../tasks/configure.yml), namathemphulethi ezilungiselelo |
| Ukuqinisekiswa kokokufakiwe nokusethwa kwama-akhawunti | I-[validate.yml](../../../tasks/validate.yml), i-[secure.yml](../../../tasks/secure.yml), i-[users.yml](../../../tasks/users.yml) |
| Ukuhlinzeka ngezizindalwazi | I-[databases.yml](../../../tasks/databases.yml) |
| Izilungiselelo zokuphindaphinda (replication) | I-[replication.yml](../../../tasks/replication.yml) isetha ama-ID eseva kanye nezilungiselelo zokuloga ngokubhinari/zabasebenzisi ohlangothini oluyinhloko |
| Amakhophi ayisipele ahleliwe | I-[backup.yml](../../../tasks/backup.yml) kanye [nethemphulethi yombhalo wokwenza ikhophi eyisipele](../../../templates/mariadb_backup.sh.j2) |
| Ukuqapha | I-[monitoring.yml](../../../tasks/monitoring.yml) namathemphulethi e-exporter/okuhlola |

Imisebenzi yokuphindaphinda efakwe kule khodi ayisenzi ukuguqukela kokunye ngokuzenzakalelayo (failover) noma ukuqaliswa okuphelele kwe-replica. Izibonelo eziningi ze-Molecule ziyisimo sokuhlola kuphela, hhayi ubufakazi bokuthunyelwa kwezibonelo eziningi emshinini owodwa. Buyekeza ukubethelwa kwekhophi eyisipele, indlela yokubuyisela, nokuhambisana kwenguqulo yesizindalwazi ngokuthunyelwa kwakho; akuqinisekiswa yile README.

## Ukufaka nokusebenzisa

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

Nikeza okuguquguqukayo kwamaphasiwedi okukhulunywe ngakho nge-Ansible Vault noma ngesistimu yakho yokuphatha izimfihlo. Sebenzisa i-[defaults/main.yml](../../../defaults/main.yml) ngamagama angempela ezinketho nezilungiselelo ezizenzakalelayo.

## Izidingo nokuhambisana

I-controller yamanje iyi-Ansible 14.5.0 / ansible-core 2.21.5 nge-Python
3.13. Isimo se-`lts` sihlola amaphakheji omdabu esistimu ku-Ubuntu
22.04, 24.04 no-26.04, i-Debian 12 no-13, kanye ne-Rocky Linux 9 no-10. Amagama afanayo e-EL
kumethadatha awaqinisekisi isitifiketi esihlukile se-RHEL noma i-AlmaLinux.

Amaphakheji omdabu esistimu ayisilungiselelo esizenzakalelayo kuwo wonke amapulatifomu ahloliwe.
Amafayela ezinqolobane zangaphandle akhona awasuswa, futhi indima
ayishintshi iseva efakiwe phakathi kwemithombo yamaphakheji noma izinhlobo ezinkulu zenguqulo. Buyekeza
ukungqubuzana komphathi wamaphakheji ngaphambi kokuthutha ukufakwa kwangaphandle okukhona.

Indlela yenqolobane yangaphandle iyinketho ecacile engahloliwe efakwa
nge-`mariadb_configure_repo: true`. Isikhethi sayo sakudala se-`mariadb_version` asiyona
inguqulo yeseva yomdabu noma isincomo sokukhishwa okusekelwayo kwe-upstream.
Izibuko ezindala ezifakwe ngqo kukhodi azihlanganisi zonke izinhlobo zamanje zesistimu; sebenzisa
isilungiselelo esizenzakalelayo somdabu noma uhlole ngokuzimela izilungiselelo zenqolobane kuqala.

Indima ithola inguqulo yeseva esebenzayo nomkhombandlela wedatha ngaphambi
kokubhala izilungiselelo. Lokhu kugcina i-`/var/lib/mariadb` ye-Ubuntu 26.04 kanye
nesitoreji sesizindalwazi esikhona. I-`mariadb_data_dir` ecacile engqubuzanayo iyehluleka
ngesidingo sokuthutha idatha; indima ayihambisi idatha. Ukuguqulwa komphakathi kwephakheji,
isevisi, isokhethi kanye namafayela ezilungiselelo kuhlala kutholakala.

Ukushintsha kwephasiwedi kusebenzisa izitatimende ezinamapharamitha ukuze i-MariaDB ikwazi ukuphoqelela
i-plugin yayo eqinile yokuqinisekisa iphasiwedi. Ifayela leklayenti eliyimfihlo lika-root lisebenzisa
isokhethi yendawo ye-Unix. Ama-akhawunti angashintshiwe agcina izimvume zawo namaphasiwedi awo.

## Ukuthuthukiswa nokuhlola

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Lezi zinhloso zichazwe ku-[Makefile](../../../Makefile). I-Molecule idinga umshayeli wayo (driver) nezidingo zokuhlola. Izinhloso ze-Docker zisebenzisa amafayela angaphansi kwe-[dev](../../../dev); i-`make docker-test` iyinhloso eyisisekelo ye-Docker, hhayi i-`make test-docker`.

## Imibhalo, ukuvikeleka, nelayisense

- [Izibonelo zezilungiselelo](../../../docs/README.md)
- [Ukufaka isandla](../../../CONTRIBUTING.md)
- [Inqubomgomo yokuvikeleka](../../../SECURITY.md)
- [Ilayisense ye-MIT](../../../LICENSE)
