<!-- translations:start -->
**Languages:** [English](../../../README.md) · **বাংলা** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** **বাংলা** · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# MariaDB Ansible রোল

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

MariaDB ইনস্টল করা, ডেটাবেস ও ব্যবহারকারী প্রভিশন করা এবং ঐচ্ছিক ব্যাকআপ ও মনিটরিং টাস্ক কনফিগার করার জন্য একটি Ansible রোল। এই রোলটি ইনস্টলেশন, কনফিগারেশন, যাচাইকরণ এবং অপারেশনাল টাস্কগুলোকে আলাদা করে রাখে যাতে প্রতিটি অংশ স্বতন্ত্রভাবে পর্যালোচনা করা যায়।

## সক্ষমতাসমূহ

| ক্ষেত্র | বাস্তবায়ন |
| --- | --- |
| ইনস্টলেশন ও কনফিগারেশন | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml), এবং কনফিগারেশন টেমপ্লেটসমূহ |
| ইনপুট যাচাইকরণ ও অ্যাকাউন্ট সেটআপ | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| ডেটাবেস প্রভিশনিং | [databases.yml](../../../tasks/databases.yml) |
| রেপ্লিকেশন সেটিংস | [replication.yml](../../../tasks/replication.yml) সার্ভার আইডি এবং প্রাইমারি-সাইড বাইনারি লগিং/ব্যবহারকারী সেটিংস নির্ধারণ করে |
| নির্ধারিত ব্যাকআপ | [backup.yml](../../../tasks/backup.yml) এবং [ব্যাকআপ স্ক্রিপ্ট টেমপ্লেট](../../../templates/mariadb_backup.sh.j2) |
| মনিটরিং | [monitoring.yml](../../../tasks/monitoring.yml) এবং এক্সপোর্টার/চেক টেমপ্লেটসমূহ |

চেক-ইন করা রেপ্লিকেশন টাস্কগুলো স্বয়ংক্রিয় ফেইলওভার বা সম্পূর্ণ রেপ্লিকা ইনিশিয়ালাইজেশন বাস্তবায়ন করে না। একাধিক Molecule ইনস্ট্যান্স একটি টেস্ট টপোলজি মাত্র, একক হোস্টে মাল্টি-ইনস্ট্যান্স ডিপ্লয়মেন্টের প্রমাণ নয়। আপনার ডিপ্লয়মেন্টের জন্য ব্যাকআপ এনক্রিপশন, রিস্টোর আচরণ এবং ডেটাবেস-সংস্করণ সামঞ্জস্যতা পর্যালোচনা করুন; এই README-তে এগুলোর নিশ্চয়তা দেওয়া হয়নি।

## ইনস্টল ও ব্যবহার

```bash
ansible-galaxy role install git+https://github.com/somethingwithproof/ansible-role-mariadb.git
ansible-galaxy collection install community.mysql
```

```yaml
- hosts: database_servers
  become: true
  vars:
    mariadb_configure_repo: false
    mariadb_allow_remote_connections: true
    mariadb_bind_address: "{{ ansible_facts.default_ipv4.address }}"
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

উল্লিখিত পাসওয়ার্ড ভেরিয়েবলগুলো Ansible Vault অথবা আপনার সিক্রেট-ম্যানেজমেন্ট সিস্টেমের মাধ্যমে সরবরাহ করুন। প্রকৃত অপশন নাম এবং ডিফল্ট মানের জন্য [defaults/main.yml](../../../defaults/main.yml) ব্যবহার করুন।

## আবশ্যকতা এবং সামঞ্জস্যতা

বর্তমান কন্ট্রোলার হলো Python 3.13-সহ Ansible 14.5.0 / ansible-core 2.21.5। `lts` সিনারিওটি Ubuntu 22.04, 24.04 ও 26.04, Debian 12 ও 13, এবং Rocky Linux 9 ও 10-এ নেটিভ ডিস্ট্রিবিউশন প্যাকেজ পরীক্ষা করে। মেটাডেটায় থাকা EL উপনামগুলো আলাদা কোনো RHEL বা AlmaLinux সার্টিফিকেশন প্রতিষ্ঠা করে না।

পরীক্ষিত প্রতিটি প্ল্যাটফর্মে নেটিভ ডিস্ট্রিবিউশন প্যাকেজই ডিফল্ট। বিদ্যমান বাহ্যিক রিপোজিটরি ফাইলগুলো অপসারণ করা হয় না, এবং রোলটি কোনো ইনস্টল করা সার্ভারকে এক প্যাকেজ উৎস বা মেজর সংস্করণ থেকে অন্যটিতে মাইগ্রেট করে না। কোনো বিদ্যমান বাহ্যিক ইনস্টলেশন মাইগ্রেট করার আগে প্যাকেজ-ম্যানেজার দ্বন্দ্ব পর্যালোচনা করুন।

বাহ্যিক রিপোজিটরি পথটি `mariadb_configure_repo: true`-এর মাধ্যমে একটি সুস্পষ্ট, অপরীক্ষিত অপ্ট-ইন। এর লিগ্যাসি `mariadb_version` সিলেক্টর কোনো নেটিভ-সার্ভার সংস্করণ বা সমর্থিত আপস্ট্রিম রিলিজের সুপারিশ নয়। পুরোনো হার্ড-কোডেড মিররগুলো বর্তমান প্রতিটি ডিস্ট্রিবিউশন কভার করে না; নেটিভ ডিফল্ট ব্যবহার করুন অথবা প্রথমে স্বতন্ত্রভাবে রিপোজিটরি কনফিগারেশন যাচাই করে নিন।

কনফিগারেশন লেখার আগে রোলটি চলমান সার্ভারের সংস্করণ এবং ডেটা ডিরেক্টরি শনাক্ত করে। এটি Ubuntu 26.04-এর `/var/lib/mariadb` এবং বিদ্যমান ডেটাবেস স্টোরেজ সংরক্ষণ করে। কোনো সুস্পষ্ট সাংঘর্ষিক `mariadb_data_dir` মাইগ্রেশনের আবশ্যকতাসহ ব্যর্থ হয়; রোলটি ডেটা স্থানান্তর করে না। পাবলিক প্যাকেজ, সার্ভিস, সকেট এবং কনফিগারেশন-ফাইল ওভাররাইডগুলো উপলব্ধ রয়ে গেছে।

পাসওয়ার্ড পরিবর্তনে প্যারামিটারাইজড স্টেটমেন্ট ব্যবহার করা হয় যাতে MariaDB এর কঠোর পাসওয়ার্ড-যাচাইকরণ প্লাগইন প্রয়োগ করতে পারে। Root-এর ব্যক্তিগত ক্লায়েন্ট ফাইল স্থানীয় Unix সকেট ব্যবহার করে। অপরিবর্তিত অ্যাকাউন্টগুলো তাদের অনুমতি (grants) এবং পাসওয়ার্ড বজায় রাখে।

## ডেভেলপমেন্ট ও টেস্টিং

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

এই টার্গেটগুলো [Makefile](../../../Makefile)-এ সংজ্ঞায়িত আছে। Molecule-এর জন্য এর ড্রাইভার এবং টেস্ট ডিপেন্ডেন্সি প্রয়োজন। Docker টার্গেটগুলো [dev](../../../dev)-এর অধীনে থাকা ফাইল ব্যবহার করে; মৌলিক Docker টার্গেট হলো `make docker-test`, `make test-docker` নয়।

## ডকুমেন্টেশন, নিরাপত্তা এবং লাইসেন্স

- [কনফিগারেশন উদাহরণসমূহ](../../../docs/README.md)
- [অবদান রাখুন](../../../CONTRIBUTING.md)
- [নিরাপত্তা নীতি](../../../SECURITY.md)
- [MIT লাইসেন্স](../../../LICENSE)
