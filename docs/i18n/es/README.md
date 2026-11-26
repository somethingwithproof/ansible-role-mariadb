<!-- translations:start -->
**Languages:** [English](../../../README.md) · [Deutsch](../de/README.md) · **Español** · [Français](../fr/README.md) · [Português (BR)](../pt-BR/README.md) · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · **Español** · [Français](../fr/README.md) · [Italiano](../it/README.md) · [Português (BR)](../pt-BR/README.md) · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Rol de Ansible para MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Un rol de Ansible para instalar MariaDB, aprovisionar bases de datos y usuarios, y configurar tareas opcionales de copias de seguridad y monitorización. El rol separa las tareas de instalación, configuración, validación y operación para que cada una pueda revisarse de forma independiente.

## Capacidades

| Área | Implementación |
| --- | --- |
| Instalación y configuración | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml) y plantillas de configuración |
| Validación de entradas y configuración de cuentas | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Aprovisionamiento de bases de datos | [databases.yml](../../../tasks/databases.yml) |
| Ajustes de replicación | [replication.yml](../../../tasks/replication.yml) configura los ID de servidor y los ajustes de registro binario y usuario en el nodo primario |
| Copias de seguridad programadas | [backup.yml](../../../tasks/backup.yml) y la [plantilla de script de copia de seguridad](../../../templates/mariadb_backup.sh.j2) |
| Monitorización | [monitoring.yml](../../../tasks/monitoring.yml) y plantillas de exportador y comprobaciones |

Las tareas de replicación incluidas en el repositorio no implementan conmutación por error automática ni una inicialización completa de réplicas. Las múltiples instancias de Molecule representan una topología de pruebas, no una evidencia de despliegue multiinstancia en un único host. Revise el cifrado de copias de seguridad, el comportamiento de restauración y la compatibilidad de versiones de la base de datos para su despliegue; este README no los garantiza.

## Instalación y uso

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

Proporcione las variables de contraseña referenciadas mediante Ansible Vault o su sistema de gestión de secretos. Consulte [defaults/main.yml](../../../defaults/main.yml) para ver los nombres reales de las opciones y sus valores predeterminados.

## Requisitos y compatibilidad

El controlador actual es Ansible 14.5.0 / ansible-core 2.21.5 con Python
3.13. El escenario `lts` valida los paquetes nativos de cada distribución en Ubuntu
22.04, 24.04 y 26.04, Debian 12 y 13, y Rocky Linux 9 y 10. Los alias de EL
en los metadatos no implican una certificación independiente para RHEL ni AlmaLinux.

Los paquetes nativos de la distribución son la opción predeterminada en todas las plataformas probadas.
Los archivos de repositorios externos existentes no se eliminan y el rol no
migra un servidor instalado entre orígenes de paquetes ni entre versiones principales. Revise
los conflictos del gestor de paquetes antes de migrar una instalación externa existente.

La ruta de repositorio externo es una opción explícita y no probada mediante
`mariadb_configure_repo: true`. Su selector heredado `mariadb_version` no corresponde a una
versión del servidor nativo ni constituye una recomendación para una versión upstream compatible.
Los antiguos espejos codificados de forma fija no cubren todas las distribuciones actuales; use la
configuración nativa predeterminada o valide primero de forma independiente la configuración del repositorio.

El rol detecta la versión y el directorio de datos del servidor en ejecución antes de
escribir la configuración. Esto preserva `/var/lib/mariadb` en Ubuntu 26.04 y el
almacenamiento existente de la base de datos. Un valor explícito en conflicto para `mariadb_data_dir` falla
solicitando una migración; el rol no mueve datos. Las sobrescrituras públicas de paquetes,
servicios, sockets y archivos de configuración siguen disponibles.

Los cambios de contraseña utilizan sentencias parametrizadas para que MariaDB pueda aplicar su
complemento estricto de validación de contraseñas. El archivo privado de cliente de root utiliza el
socket Unix local. Las cuentas sin cambios conservan sus privilegios y contraseñas.

## Desarrollo y pruebas

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Estos objetivos están definidos en el [Makefile](../../../Makefile). Molecule requiere su controlador y sus dependencias de pruebas. Los objetivos de Docker utilizan archivos en [dev](../../../dev); `make docker-test` es el objetivo básico de Docker, no `make test-docker`.

## Documentación, seguridad y licencia

- [Ejemplos de configuración](../../../docs/README.md)
- [Cómo contribuir](../../../CONTRIBUTING.md)
- [Política de seguridad](../../../SECURITY.md)
- [Licencia MIT](../../../LICENSE)
