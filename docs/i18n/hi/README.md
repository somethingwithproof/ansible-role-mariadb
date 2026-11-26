<!-- translations:start -->
**Languages:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · **हिन्दी**

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · **हिन्दी** · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# MariaDB Ansible रोल

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

MariaDB इंस्टॉल करने, डेटाबेस और उपयोगकर्ताओं को प्रोविज़न करने, तथा वैकल्पिक बैकअप और मॉनिटरिंग कार्यों को कॉन्फ़िगर करने के लिए एक Ansible रोल। यह रोल इंस्टॉलेशन, कॉन्फ़िगरेशन, सत्यापन और परिचालन कार्यों को अलग रखता है ताकि प्रत्येक की स्वतंत्र रूप से समीक्षा की जा सके।

## क्षमताएँ

| क्षेत्र | कार्यान्वयन |
| --- | --- |
| इंस्टॉलेशन और कॉन्फ़िगरेशन | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml), और कॉन्फ़िगरेशन टेम्पलेट |
| इनपुट सत्यापन और खाता सेटअप | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| डेटाबेस प्रोविज़निंग | [databases.yml](../../../tasks/databases.yml) |
| रेप्लिकेशन सेटिंग्स | [replication.yml](../../../tasks/replication.yml) सर्वर ID और प्राइमरी-साइड बाइनरी लॉगिंग/उपयोगकर्ता सेटिंग्स निर्धारित करता है |
| निर्धारित बैकअप | [backup.yml](../../../tasks/backup.yml) और [बैकअप स्क्रिप्ट टेम्पलेट](../../../templates/mariadb_backup.sh.j2) |
| मॉनिटरिंग | [monitoring.yml](../../../tasks/monitoring.yml) और एक्सपोर्टर/जाँच टेम्पलेट |

रिपॉजिटरी में शामिल रेप्लिकेशन कार्य स्वचालित फ़ेलओवर या पूर्ण रेप्लिका इनिशियलाइज़ेशन को लागू नहीं करते हैं। एकाधिक Molecule इंस्टेंस एक परीक्षण टोपोलॉजी हैं, न कि एक ही होस्ट पर मल्टी-इंस्टेंस परिनियोजन का प्रमाण। अपने परिनियोजन के लिए बैकअप एन्क्रिप्शन, रिस्टोर व्यवहार और डेटाबेस-संस्करण संगतता की समीक्षा करें; इस README द्वारा इनकी गारंटी नहीं दी जाती है।

## इंस्टॉल और उपयोग

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

संदर्भित पासवर्ड वेरिएबल को Ansible Vault या अपने सीक्रेट-प्रबंधन सिस्टम के माध्यम से प्रदान करें। वास्तविक विकल्प नामों और डिफ़ॉल्ट के लिए [defaults/main.yml](../../../defaults/main.yml) का उपयोग करें।

## आवश्यकताएँ और संगतता

वर्तमान कंट्रोलर Python 3.13 के साथ Ansible 14.5.0 / ansible-core 2.21.5 है। `lts` परिदृश्य Ubuntu 22.04, 24.04 और 26.04, Debian 12 और 13, तथा Rocky Linux 9 और 10 पर नेटिव डिस्ट्रीब्यूशन पैकेजों का परीक्षण करता है। मेटाडेटा में EL उपनाम अलग RHEL या AlmaLinux प्रमाणन को सिद्ध नहीं करते हैं।

प्रत्येक परीक्षित प्लेटफ़ॉर्म पर नेटिव डिस्ट्रीब्यूशन पैकेज डिफ़ॉल्ट होते हैं। मौजूदा बाहरी रिपॉजिटरी फ़ाइलों को हटाया नहीं जाता है, और यह रोल किसी इंस्टॉल किए गए सर्वर को पैकेज स्रोतों या प्रमुख संस्करणों के बीच माइग्रेट नहीं करता है। किसी मौजूदा बाहरी इंस्टॉलेशन को माइग्रेट करने से पहले पैकेज-मैनेजर विरोधों की समीक्षा करें।

बाहरी रिपॉजिटरी पाथ `mariadb_configure_repo: true` के माध्यम से एक स्पष्ट, अपरीक्षित ऑप्ट-इन है। इसका लेगेसी `mariadb_version` चयनकर्ता कोई नेटिव-सर्वर संस्करण या किसी समर्थित अपस्ट्रीम रिलीज़ की अनुशंसा नहीं है। पुराने हार्ड-कोडेड मिरर प्रत्येक वर्तमान डिस्ट्रीब्यूशन को कवर नहीं करते हैं; नेटिव डिफ़ॉल्ट का उपयोग करें या पहले स्वतंत्र रूप से रिपॉजिटरी कॉन्फ़िगरेशन को सत्यापित करें।

कॉन्फ़िगरेशन लिखने से पहले यह रोल चल रहे सर्वर के संस्करण और डेटा डायरेक्टरी का पता लगाता है। इससे Ubuntu 26.04 की `/var/lib/mariadb` और मौजूदा डेटाबेस स्टोरेज सुरक्षित रहता है। एक स्पष्ट विरोधाभासी `mariadb_data_dir` माइग्रेशन आवश्यकता के साथ विफल हो जाता है; यह रोल डेटा को स्थानांतरित नहीं करता है। सार्वजनिक पैकेज, सेवा, सॉकेट और कॉन्फ़िगरेशन-फ़ाइल ओवरराइड उपलब्ध रहते हैं।

पासवर्ड परिवर्तन पैरामीटराइज़्ड स्टेटमेंट का उपयोग करते हैं ताकि MariaDB अपने सख्त पासवर्ड-सत्यापन प्लगइन को लागू कर सके। रूट की निजी क्लाइंट फ़ाइल स्थानीय Unix सॉकेट का उपयोग करती है। अपरिवर्तित खाते अपने अधिकार (grants) और पासवर्ड बनाए रखते हैं।

## विकास और परीक्षण

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

ये टारगेट [Makefile](../../../Makefile) में परिभाषित हैं। Molecule को अपने ड्राइवर और परीक्षण निर्भरताओं की आवश्यकता होती है। Docker टारगेट [dev](../../../dev) के अंतर्गत फ़ाइलों का उपयोग करते हैं; `make docker-test` बुनियादी Docker टारगेट है, न कि `make test-docker`।

## दस्तावेज़ीकरण, सुरक्षा और लाइसेंस

- [कॉन्फ़िगरेशन उदाहरण](../../../docs/README.md)
- [योगदान](../../../CONTRIBUTING.md)
- [सुरक्षा नीति](../../../SECURITY.md)
- [MIT लाइसेंस](../../../LICENSE)
