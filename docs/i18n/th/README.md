<!-- translations:start -->
**Languages:** [English](../../../README.md) · **ไทย** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · **ไทย** · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# MariaDB Ansible Role

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

role ของ Ansible สำหรับติดตั้ง MariaDB จัดเตรียมฐานข้อมูลและผู้ใช้ รวมถึงกำหนดค่างานสำรองข้อมูลและการมอนิเตอร์แบบเลือกเปิดใช้งานได้ role นี้แยกงานด้านการติดตั้ง การกำหนดค่า การตรวจสอบความถูกต้อง และงานปฏิบัติการออกจากกัน เพื่อให้สามารถตรวจสอบแต่ละส่วนได้อย่างอิสระ

## ความสามารถ

| ส่วนงาน | การนำไปใช้งาน |
| --- | --- |
| การติดตั้งและการกำหนดค่า | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml) และเทมเพลตการกำหนดค่า |
| การตรวจสอบข้อมูลนำเข้าและการตั้งค่าบัญชี | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| การจัดเตรียมฐานข้อมูล | [databases.yml](../../../tasks/databases.yml) |
| การตั้งค่าการทำสำเนาข้อมูล (Replication) | [replication.yml](../../../tasks/replication.yml) กำหนด server ID และการตั้งค่า binary logging/ผู้ใช้ฝั่ง primary |
| การสำรองข้อมูลตามกำหนดเวลา | [backup.yml](../../../tasks/backup.yml) และ[เทมเพลตสคริปต์สำรองข้อมูล](../../../templates/mariadb_backup.sh.j2) |
| การมอนิเตอร์ | [monitoring.yml](../../../tasks/monitoring.yml) และเทมเพลต exporter/สคริปต์ตรวจสอบ |

งานด้าน replication ที่มีอยู่ในโค้ดไม่ได้รองรับการสลับระบบอัตโนมัติ (automated failover) หรือการตั้งค่า replica เริ่มต้นอย่างครบวงจร การใช้อินสแตนซ์ Molecule หลายตัวเป็นเพียงโทโพโลยีสำหรับการทดสอบ ไม่ใช่หลักฐานยืนยันการดีพลอยหลายอินสแตนซ์บนโฮสต์เดียวกัน โปรดตรวจสอบการเข้ารหัสข้อมูลสำรอง พฤติกรรมการกู้คืน และความเข้ากันได้ของเวอร์ชันฐานข้อมูลให้เหมาะกับการดีพลอยของคุณเอง เนื่องจาก README นี้ไม่ได้ให้การรับประกันในส่วนดังกล่าว

## การติดตั้งและการใช้งาน

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

จัดเตรียมตัวแปรรหัสผ่านที่อ้างอิงผ่าน Ansible Vault หรือระบบจัดการความลับของคุณ ดูชื่อตัวเลือกและค่าเริ่มต้นจริงได้จาก [defaults/main.yml](../../../defaults/main.yml)

## ข้อกำหนดและความเข้ากันได้

คอนโทรลเลอร์ปัจจุบันคือ Ansible 14.5.0 / ansible-core 2.21.5 ร่วมกับ Python 3.13 สถานการณ์ทดสอบ `lts` ทดสอบแพ็กเกจเนทีฟของดิสทริบิวชันบน Ubuntu 22.04, 24.04 และ 26.04, Debian 12 และ 13 รวมถึง Rocky Linux 9 และ 10 ชื่อแทน (alias) ของตระกูล EL ในข้อมูลเมตาไม่ได้เป็นการรับรอง RHEL หรือ AlmaLinux แยกต่างหาก

แพ็กเกจเนทีฟของดิสทริบิวชันเป็นค่าเริ่มต้นบนทุกแพลตฟอร์มที่ทดสอบ ไฟล์รีโพซิทอรีภายนอกที่มีอยู่จะไม่ถูกลบออก และ role นี้ไม่ได้ทำการย้ายเซิร์ฟเวอร์ที่ติดตั้งไว้แล้วระหว่างแหล่งแพ็กเกจหรือระหว่างเวอร์ชันหลัก โปรดตรวจสอบความขัดแย้งของตัวจัดการแพ็กเกจก่อนย้ายการติดตั้งจากแหล่งภายนอกที่มีอยู่เดิม

เส้นทางรีโพซิทอรีภายนอกเป็นการเลือกเปิดใช้งานอย่างชัดเจนซึ่งยังไม่ได้ผ่านการทดสอบ ผ่านการตั้งค่า `mariadb_configure_repo: true` ตัวเลือก `mariadb_version` แบบเดิมไม่ใช่เวอร์ชันของเซิร์ฟเวอร์เนทีฟและไม่ใช่คำแนะนำสำหรับรีลีสต้นน้ำที่รองรับ รายการมิเรอร์เก่าที่เขียนตายตัวไว้ไม่ได้ครอบคลุมทุกดิสทริบิวชันในปัจจุบัน ควรใช้ค่าเริ่มต้นแบบเนทีฟหรือตรวจสอบคุณสมบัติการกำหนดค่ารีโพซิทอรีด้วยตนเองก่อน

role จะตรวจสอบเวอร์ชันและไดเรกทอรีข้อมูลของเซิร์ฟเวอร์ที่กำลังทำงานอยู่ก่อนเขียนไฟล์กำหนดค่า เพื่อรักษา `/var/lib/mariadb` ของ Ubuntu 26.04 และที่จัดเก็บข้อมูลฐานข้อมูลที่มีอยู่เดิมไว้ หากมีการระบุ `mariadb_data_dir` ที่ขัดแย้งกันอย่างชัดเจน การทำงานจะล้มเหลวพร้อมแจ้งว่าต้องทำการย้ายข้อมูล เนื่องจาก role ไม่ได้ย้ายข้อมูลให้ การเขียนทับค่าสาธารณะสำหรับแพ็กเกจ เซอร์วิส ซ็อกเก็ต และไฟล์กำหนดค่ายังคงใช้งานได้ตามปกติ

การเปลี่ยนรหัสผ่านใช้คำสั่งแบบพารามิเตอร์ (parameterized statements) เพื่อให้ MariaDB สามารถบังคับใช้ปลั๊กอินตรวจสอบความซับซ้อนของรหัสผ่านได้อย่างเข้มงวด ไฟล์ไคลเอนต์ส่วนตัวของ root ใช้ Unix socket ภายในเครื่อง ส่วนบัญชีที่ไม่มีการเปลี่ยนแปลงจะยังคงสิทธิ์การใช้งานและรหัสผ่านเดิมไว้

## การพัฒนาและการทดสอบ

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

ทาร์เก็ตเหล่านี้ถูกกำหนดไว้ใน [Makefile](../../../Makefile) Molecule จำเป็นต้องมีไดรเวอร์และดีเพนเดนซีสำหรับการทดสอบ ทาร์เก็ตของ Docker ใช้ไฟล์ภายใต้ [dev](../../../dev) โดย `make docker-test` คือทาร์เก็ต Docker พื้นฐาน ไม่ใช่ `make test-docker`

## เอกสารประกอบ ความปลอดภัย และสัญญาอนุญาต

- [ตัวอย่างการกำหนดค่า](../../../docs/README.md)
- [การมีส่วนร่วม](../../../CONTRIBUTING.md)
- [นโยบายความปลอดภัย](../../../SECURITY.md)
- [สัญญาอนุญาต MIT](../../../LICENSE)
