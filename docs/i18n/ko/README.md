<!-- translations:start -->
**Languages:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · **한국어** · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · **한국어** · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# MariaDB Ansible 역할

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

MariaDB 설치, 데이터베이스 및 사용자 프로비저닝, 선택적 백업 및 모니터링 작업 구성을 위한 Ansible 역할입니다. 이 역할은 설치, 구성, 검증 및 운영 작업을 분리하여 각 단계를 독립적으로 검토할 수 있도록 합니다.

## 주요 기능

| 영역 | 구현 |
| --- | --- |
| 설치 및 구성 | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml) 및 구성 템플릿 |
| 입력값 검증 및 계정 설정 | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| 데이터베이스 프로비저닝 | [databases.yml](../../../tasks/databases.yml) |
| 복제 설정 | [replication.yml](../../../tasks/replication.yml)은 서버 ID 및 프라이머리 측 바이너리 로깅/사용자 설정을 구성 |
| 예약 백업 | [backup.yml](../../../tasks/backup.yml) 및 [백업 스크립트 템플릿](../../../templates/mariadb_backup.sh.j2) |
| 모니터링 | [monitoring.yml](../../../tasks/monitoring.yml) 및 익스포터/점검 템플릿 |

저장소에 포함된 복제 작업은 자동 장애 조치나 완전한 레플리카 초기화를 구현하지 않습니다. 여러 Molecule 인스턴스는 테스트 토폴로지일 뿐, 단일 호스트에서의 다중 인스턴스 배포를 입증하는 근거가 아닙니다. 실제 배포 환경에 맞춰 백업 암호화, 복원 동작 및 데이터베이스 버전 호환성을 직접 검토하세요. 이 README는 해당 사항을 보장하지 않습니다.

## 설치 및 사용

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

참조되는 비밀번호 변수는 Ansible Vault 또는 사용 중인 시크릿 관리 시스템을 통해 제공하세요. 실제 옵션 이름과 기본값은 [defaults/main.yml](../../../defaults/main.yml)을 참고하세요.

## 요구 사항 및 호환성

현재 컨트롤러는 Python 3.13 환경의 Ansible 14.5.0 / ansible-core 2.21.5입니다. `lts` 시나리오는 Ubuntu 22.04, 24.04 및 26.04, Debian 12 및 13, 그리고 Rocky Linux 9 및 10의 네이티브 배포판 패키지를 검증합니다. 메타데이터의 EL 별칭이 별도의 RHEL 또는 AlmaLinux 인증을 의미하지는 않습니다.

테스트된 모든 플랫폼에서 네이티브 배포판 패키지가 기본값입니다. 기존 외부 저장소 파일은 제거되지 않으며, 이 역할은 설치된 서버를 패키지 소스 간 또는 메이저 버전 간에 마이그레이션하지 않습니다. 기존 외부 설치 환경에서 마이그레이션하기 전에 패키지 관리자 충돌 여부를 검토하세요.

외부 저장소 경로는 `mariadb_configure_repo: true`를 통해 명시적으로 선택하는 미검증 옵트인(opt-in) 기능입니다. 레거시 `mariadb_version` 선택기는 네이티브 서버 버전이나 지원되는 업스트림 릴리스에 대한 권장 사항이 아닙니다. 오래된 하드코딩된 미러는 현재의 모든 배포판을 지원하지 않으므로, 네이티브 기본값을 사용하거나 저장소 구성을 먼저 독립적으로 검증하세요.

이 역할은 구성을 작성하기 전에 실행 중인 서버의 버전과 데이터 디렉터리를 탐지합니다. 이를 통해 Ubuntu 26.04의 `/var/lib/mariadb`와 기존 데이터베이스 스토리지를 보존합니다. 충돌하는 `mariadb_data_dir`를 명시적으로 지정하면 마이그레이션이 필요하다는 오류와 함께 실패하며, 이 역할은 데이터를 이동하지 않습니다. 공개 패키지, 서비스, 소켓 및 구성 파일 재정의 옵션은 그대로 사용할 수 있습니다.

비밀번호 변경에는 매개변수화된 구문을 사용하여 MariaDB가 엄격한 비밀번호 검증 플러그인을 적용할 수 있도록 합니다. root의 비공개 클라이언트 파일은 로컬 Unix 소켓을 사용합니다. 변경되지 않은 계정은 기존 권한과 비밀번호를 유지합니다.

## 개발 및 테스트

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

이러한 타깃은 [Makefile](../../../Makefile)에 정의되어 있습니다. Molecule을 실행하려면 드라이버와 테스트 의존성이 필요합니다. Docker 타깃은 [dev](../../../dev) 아래의 파일을 사용하며, 기본 Docker 타깃은 `make test-docker`가 아니라 `make docker-test`입니다.

## 문서, 보안 및 라이선스

- [구성 예제](../../../docs/README.md)
- [기여 가이드](../../../CONTRIBUTING.md)
- [보안 정책](../../../SECURITY.md)
- [MIT 라이선스](../../../LICENSE)
