<!-- translations:start -->
**Languages:** [English](../../../README.md) · **Tiếng Việt** · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · **Tiếng Việt** · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Vai trò Ansible cho MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Một vai trò Ansible dùng để cài đặt MariaDB, khởi tạo cơ sở dữ liệu và người dùng, đồng thời cấu hình các tác vụ sao lưu và giám sát tùy chọn. Vai trò này tách riêng các tác vụ cài đặt, cấu hình, kiểm tra hợp lệ và vận hành để có thể rà soát độc lập từng phần.

## Tính năng

| Lĩnh vực | Triển khai |
| --- | --- |
| Cài đặt và cấu hình | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml) và các mẫu cấu hình |
| Kiểm tra đầu vào và thiết lập tài khoản | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Khởi tạo cơ sở dữ liệu | [databases.yml](../../../tasks/databases.yml) |
| Thiết lập sao chép (replication) | [replication.yml](../../../tasks/replication.yml) cấu hình server ID và các thiết lập binary logging/người dùng phía máy chủ chính |
| Sao lưu theo lịch | [backup.yml](../../../tasks/backup.yml) và [mẫu kịch bản sao lưu](../../../templates/mariadb_backup.sh.j2) |
| Giám sát | [monitoring.yml](../../../tasks/monitoring.yml) cùng các mẫu exporter/kiểm tra |

Các tác vụ sao chép hiện có không triển khai chuyển đổi dự phòng tự động hay khởi tạo bản sao hoàn chỉnh. Nhiều phiên bản Molecule chỉ là cấu trúc liên kết kiểm thử, không phải bằng chứng cho việc triển khai đa phiên bản trên cùng một máy chủ. Hãy tự rà soát mã hóa bản sao lưu, cơ chế khôi phục và khả năng tương thích phiên bản cơ sở dữ liệu cho hệ thống triển khai của bạn; tệp README này không đảm bảo những yếu tố đó.

## Cài đặt và sử dụng

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

Cung cấp các biến mật khẩu được tham chiếu thông qua Ansible Vault hoặc hệ thống quản lý bí mật của bạn. Xem [defaults/main.yml](../../../defaults/main.yml) để biết tên tùy chọn và giá trị mặc định thực tế.

## Yêu cầu và khả năng tương thích

Máy điều khiển hiện tại sử dụng Ansible 14.5.0 / ansible-core 2.21.5 với Python 3.13. Kịch bản `lts` kiểm thử các gói phần mềm gốc của bản phân phối trên Ubuntu 22.04, 24.04 và 26.04, Debian 12 và 13, cũng như Rocky Linux 9 và 10. Các tên gọi tương đương của EL trong siêu dữ liệu không đại diện cho chứng nhận riêng cho RHEL hay AlmaLinux.

Các gói gốc của bản phân phối là lựa chọn mặc định trên mọi nền tảng được kiểm thử. Các tệp kho lưu trữ bên ngoài hiện có sẽ không bị xóa, và vai trò này không thực hiện di chuyển máy chủ đã cài đặt giữa các nguồn gói hoặc các phiên bản chính. Hãy rà soát xung đột trình quản lý gói trước khi di chuyển một bản cài đặt từ nguồn bên ngoài hiện có.

Đường dẫn kho lưu trữ bên ngoài là tùy chọn bật thủ công, chưa qua kiểm thử thông qua `mariadb_configure_repo: true`. Bộ chọn cũ `mariadb_version` không phải là phiên bản máy chủ gốc hay khuyến nghị cho một bản phát hành thượng nguồn được hỗ trợ. Các máy chủ gương (mirror) được mã hóa cứng trước đây không bao phủ mọi bản phân phối hiện tại; hãy dùng cấu hình gói gốc mặc định hoặc tự kiểm chứng độc lập cấu hình kho lưu trữ trước.

Vai trò sẽ tự phát hiện phiên bản máy chủ đang chạy và thư mục dữ liệu trước khi ghi cấu hình. Điều này giúp giữ nguyên thư mục `/var/lib/mariadb` trên Ubuntu 26.04 và vùng lưu trữ cơ sở dữ liệu hiện có. Nếu biến `mariadb_data_dir` được chỉ định tường minh bị xung đột, tác vụ sẽ dừng với yêu cầu di chuyển dữ liệu; vai trò không tự di chuyển dữ liệu. Các tùy chọn ghi đè công khai cho gói, dịch vụ, socket và tệp cấu hình vẫn được giữ nguyên.

Việc đổi mật khẩu sử dụng các câu lệnh tham số hóa để MariaDB có thể áp dụng plugin kiểm tra mật khẩu nghiêm ngặt. Tệp cấu hình máy khách riêng của tài khoản root sử dụng Unix socket cục bộ. Các tài khoản không thay đổi vẫn giữ nguyên quyền hạn và mật khẩu.

## Phát triển và kiểm thử

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Các mục tiêu này được định nghĩa trong [Makefile](../../../Makefile). Molecule yêu cầu trình điều khiển (driver) và các thành phần phụ thuộc kiểm thử của nó. Các mục tiêu Docker sử dụng các tệp trong [dev](../../../dev); `make docker-test` là mục tiêu Docker cơ bản, không phải `make test-docker`.

## Tài liệu, bảo mật và giấy phép

- [Ví dụ cấu hình](../../../docs/README.md)
- [Đóng góp](../../../CONTRIBUTING.md)
- [Chính sách bảo mật](../../../SECURITY.md)
- [Giấy phép MIT](../../../LICENSE)
