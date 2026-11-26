<!-- translations:start -->
**Languages:** [English](../../../README.md) · **मराठी** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · **मराठी** · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# MariaDB Ansible रोल

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

MariaDB इन्स्टॉल करण्यासाठी, डेटाबेस आणि वापरकर्ते तयार करण्यासाठी तसेच पर्यायी बॅकअप आणि मॉनिटरिंग टास्क्स कॉन्फिगर करण्यासाठी एक Ansible रोल. हा रोल इन्स्टॉलेशन, कॉन्फिगरेशन, पडताळणी आणि ऑपरेशनल टास्क्स वेगळे ठेवतो जेणेकरून प्रत्येकाचे स्वतंत्रपणे पुनरावलोकन करता येईल.

## क्षमता

| क्षेत्र | अंमलबजावणी |
| --- | --- |
| इन्स्टॉलेशन आणि कॉन्फिगरेशन | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml), आणि कॉन्फिगरेशन टेम्प्लेट्स |
| इनपुट पडताळणी आणि खाते सेटअप | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| डेटाबेस प्रोव्हिजनिंग | [databases.yml](../../../tasks/databases.yml) |
| रेप्लिकेशन सेटिंग्ज | [replication.yml](../../../tasks/replication.yml) सर्व्हर IDs आणि प्रायमरी-साइड बायनरी लॉगिंग/वापरकर्ता सेटिंग्ज सेट करते |
| नियोजित बॅकअप्स | [backup.yml](../../../tasks/backup.yml) आणि [बॅकअप स्क्रिप्ट टेम्प्लेट](../../../templates/mariadb_backup.sh.j2) |
| मॉनिटरिंग | [monitoring.yml](../../../tasks/monitoring.yml) आणि एक्सपोर्टर/तपासणी टेम्प्लेट्स |

चेक-इन केलेल्या रेप्लिकेशन टास्क्समध्ये स्वयंचलित फेलओव्हर किंवा संपूर्ण रेप्लिका इनिशियलायझेशनची अंमलबजावणी नाही. अनेक Molecule इन्स्टन्सेस ही एक चाचणी टोपोलॉजी आहे, एकाच होस्टवर बहु-इन्स्टन्स डिप्लॉयमेंटचा पुरावा नाही. तुमच्या डिप्लॉयमेंटसाठी बॅकअप एन्क्रिप्शन, रिस्टोअर वर्तन आणि डेटाबेस-आवृत्ती सुसंगतता यांचे पुनरावलोकन करा; या README द्वारे त्यांची हमी दिली जात नाही.

## इन्स्टॉलेशन आणि वापर

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

संदर्भित पासवर्ड व्हेरिएबल्स Ansible Vault किंवा तुमच्या सिक्रेट-मॅनेजमेंट सिस्टमद्वारे प्रदान करा. प्रत्यक्ष पर्याय नावे आणि डीफॉल्ट्ससाठी [defaults/main.yml](../../../defaults/main.yml) वापरा.

## आवश्यकता आणि सुसंगतता

सध्याचा कंट्रोलर Python 3.13 सह Ansible 14.5.0 / ansible-core 2.21.5 आहे. `lts` सिनॅरिओ Ubuntu 22.04, 24.04 आणि 26.04, Debian 12 आणि 13, तसेच Rocky Linux 9 आणि 10 वरील मूळ डिस्ट्रिब्युशन पॅकेजेसची चाचणी करतो. मेटाडेटामधील EL अ‍ॅलिअसेस स्वतंत्र RHEL किंवा AlmaLinux प्रमाणन स्थापित करत नाहीत.

प्रत्येक चाचणी केलेल्या प्लॅटफॉर्मवर मूळ डिस्ट्रिब्युशन पॅकेजेस हे डीफॉल्ट आहेत. विद्यमान बाह्य रिपॉझिटरी फाइल्स काढून टाकल्या जात नाहीत आणि हा रोल इन्स्टॉल केलेल्या सर्व्हरला पॅकेज स्रोतांमध्ये किंवा प्रमुख आवृत्त्यांमध्ये स्थलांतरित करत नाही. विद्यमान बाह्य इन्स्टॉलेशन स्थलांतरित करण्यापूर्वी पॅकेज-मॅनेजर संघर्षांचे पुनरावलोकन करा.

बाह्य रिपॉझिटरी मार्ग हा `mariadb_configure_repo: true` द्वारे स्पष्ट, चाचणी न केलेला पर्यायी निवड (opt-in) आहे. त्याचा जुना `mariadb_version` सिलेक्टर ही मूळ-सर्व्हर आवृत्ती किंवा समर्थित अपस्ट्रीम रिलीजसाठी शिफारस नाही. जुने हार्ड-कोडेड मिरर्स प्रत्येक सध्याच्या डिस्ट्रिब्युशनला कव्हर करत नाहीत; मूळ डीफॉल्ट वापरा किंवा आधी रिपॉझिटरी कॉन्फिगरेशनची स्वतंत्रपणे पडताळणी करा.

कॉन्फिगरेशन लिहिण्यापूर्वी हा रोल चालू असलेल्या सर्व्हरची आवृत्ती आणि डेटा डिरेक्टरी शोधतो. यामुळे Ubuntu 26.04 ची `/var/lib/mariadb` आणि विद्यमान डेटाबेस स्टोरेज सुरक्षित राहते. स्पष्टपणे विसंगत असलेले `mariadb_data_dir` स्थलांतरणाच्या आवश्यकतेसह अयशस्वी होते; हा रोल डेटा हलवत नाही. सार्वजनिक पॅकेज, सर्व्हिस, सॉकेट आणि कॉन्फिगरेशन-फाइल ओव्हरराइड्स उपलब्ध राहतात.

पासवर्ड बदलांसाठी पॅरामिटराइज्ड स्टेटमेंट्स वापरली जातात जेणेकरून MariaDB त्याचे कठोर पासवर्ड-पडताळणी प्लगइन लागू करू शकेल. Root ची खाजगी क्लायंट फाइल स्थानिक Unix सॉकेट वापरते. बदल न केलेल्या खात्यांचे परवाने (grants) आणि पासवर्ड कायम राहतात.

## विकास आणि चाचणी

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

ही टार्गेट्स [Makefile](../../../Makefile) मध्ये परिभाषित केली आहेत. Molecule ला त्याचा ड्रायव्हर आणि चाचणी अवलंबने (dependencies) आवश्यक आहेत. Docker टार्गेट्स [dev](../../../dev) अंतर्गत फाइल्स वापरतात; `make docker-test` हे मूलभूत Docker टार्गेट आहे, `make test-docker` नाही.

## दस्तऐवजीकरण, सुरक्षा आणि परवाना

- [कॉन्फिगरेशन उदाहरणे](../../../docs/README.md)
- [योगदान](../../../CONTRIBUTING.md)
- [सुरक्षा धोरण](../../../SECURITY.md)
- [MIT परवाना](../../../LICENSE)
