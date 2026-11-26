<!-- translations:start -->
**Languages:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · **Português (BR)** · [Русский](../ru/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md)

<details>
<summary>All 45 languages (Tier 1, Africa, Asia)</summary>

- **Tier 1:** [English](../../../README.md) · [Deutsch](../de/README.md) · [Español](../es/README.md) · [Français](../fr/README.md) · [Italiano](../it/README.md) · **Português (BR)** · [Nederlands](../nl/README.md) · [Русский](../ru/README.md) · [Українська](../uk/README.md) · [日本語](../ja/README.md) · [한국어](../ko/README.md) · [简体中文](../zh-CN/README.md) · [繁體中文](../zh-TW/README.md) · [العربية](../ar/README.md) · [हिन्दी](../hi/README.md) · [Polski](../pl/README.md) · [Türkçe](../tr/README.md) · [Svenska](../sv/README.md) · [Tiếng Việt](../vi/README.md) · [Bahasa Indonesia](../id/README.md)
- **Africa:** [Afrikaans](../af-ZA/README.md) · [አማርኛ](../am-ET/README.md) · [العربية (مصر)](../ar-EG/README.md) · [العربية (المغرب)](../ar-MA/README.md) · [Français (Maroc)](../fr-MA/README.md) · [Français (Sénégal)](../fr-SN/README.md) · [Hausa](../ha-NG/README.md) · [Igbo](../ig-NG/README.md) · [Malagasy](../mg-MG/README.md) · [Kinyarwanda](../rw-RW/README.md) · [Soomaali](../so-SO/README.md) · [Kiswahili](../sw-KE/README.md) · [isiXhosa](../xh-ZA/README.md) · [Yorùbá](../yo-NG/README.md) · [isiZulu](../zu-ZA/README.md)
- **Asia:** [বাংলা](../bn/README.md) · [فارسی](../fa/README.md) · [עברית](../he/README.md) · [मराठी](../mr/README.md) · [தமிழ்](../ta/README.md) · [తెలుగు](../te/README.md) · [ไทย](../th/README.md) · [اردو](../ur/README.md) · [Bahasa Melayu](../ms/README.md) · [Filipino](../fil/README.md)

</details>
<!-- translations:end -->

# Role Ansible para MariaDB

[![CI](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/somethingwithproof/ansible-role-mariadb/actions/workflows/ci.yml)
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=somethingwithproof_ansible-role-mariadb&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=somethingwithproof_ansible-role-mariadb)
[![License](https://img.shields.io/badge/license-MIT-blue)](../../../LICENSE)
[![OpenSSF Scorecard](https://api.scorecard.dev/projects/github.com/somethingwithproof/ansible-role-mariadb/badge)](https://scorecard.dev/viewer/?uri=github.com/somethingwithproof/ansible-role-mariadb)

Uma role Ansible para instalar o MariaDB, provisionar bancos de dados e usuários e configurar tarefas opcionais de backup e monitoramento. A role separa instalação, configuração, validação e tarefas operacionais para que cada etapa possa ser revisada de forma independente.

## Recursos

| Área | Implementação |
| --- | --- |
| Instalação e configuração | [install.yml](../../../tasks/install.yml), [configure.yml](../../../tasks/configure.yml) e templates de configuração |
| Validação de entradas e configuração de contas | [validate.yml](../../../tasks/validate.yml), [secure.yml](../../../tasks/secure.yml), [users.yml](../../../tasks/users.yml) |
| Provisionamento de bancos de dados | [databases.yml](../../../tasks/databases.yml) |
| Configurações de replicação | [replication.yml](../../../tasks/replication.yml) define IDs de servidor e configurações de log binário/usuário no primário |
| Backups agendados | [backup.yml](../../../tasks/backup.yml) e o [template do script de backup](../../../templates/mariadb_backup.sh.j2) |
| Monitoramento | [monitoring.yml](../../../tasks/monitoring.yml) e templates de exporter/verificações |

As tarefas de replicação incluídas no repositório não implementam failover automático nem inicialização completa de réplicas. Múltiplas instâncias do Molecule constituem uma topologia de testes, não evidência de implantação multi-instância em um único host. Revise a criptografia de backups, o comportamento de restauração e a compatibilidade de versão do banco de dados para a sua implantação; eles não são garantidos por este README.

## Instalação e uso

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

Forneça as variáveis de senha referenciadas por meio do Ansible Vault ou do seu sistema de gerenciamento de segredos. Consulte [defaults/main.yml](../../../defaults/main.yml) para obter os nomes reais das opções e os valores padrão.

## Requisitos e compatibilidade

O controlador atual é o Ansible 14.5.0 / ansible-core 2.21.5 com Python
3.13. O cenário `lts` exercita pacotes nativos da distribuição no Ubuntu
22.04, 24.04 e 26.04, Debian 12 e 13 e Rocky Linux 9 e 10. Aliases do EL
nos metadados não estabelecem certificação separada para RHEL ou AlmaLinux.

Os pacotes nativos da distribuição são o padrão em todas as plataformas testadas.
Arquivos existentes de repositórios externos não são removidos, e a role não
migra um servidor instalado entre origens de pacotes ou versões principais. Revise
conflitos do gerenciador de pacotes antes de migrar uma instalação externa existente.

O caminho de repositório externo é uma opção explícita e não testada ativada por
`mariadb_configure_repo: true`. Seu seletor legado `mariadb_version` não representa
uma versão do servidor nativo nem uma recomendação para um lançamento upstream suportado.
Os espelhos antigos fixados no código não cobrem todas as distribuições atuais; use o
padrão nativo ou qualifique a configuração do repositório de forma independente primeiro.

A role descobre a versão e o diretório de dados do servidor em execução antes de
gravar a configuração. Isso preserva o diretório `/var/lib/mariadb` do Ubuntu 26.04 e
o armazenamento de banco de dados existente. Um valor explícito e conflitante de `mariadb_data_dir` falha
exigindo migração; a role não move dados. As substituições públicas de pacote,
serviço, socket e arquivo de configuração continuam disponíveis.

As alterações de senha usam instruções parametrizadas para que o MariaDB possa aplicar seu
plugin rigoroso de validação de senhas. O arquivo de cliente privado do root utiliza o
socket Unix local. Contas não alteradas mantêm suas permissões e senhas.

## Desenvolvimento e testes

```bash
make lint
make molecule-test
mise exec python@3.13 -- molecule test -s lts
make backup-test
make monitoring-test
make version-matrix-test
```

Esses alvos estão definidos no [Makefile](../../../Makefile). O Molecule exige seu driver e dependências de teste. Os alvos do Docker usam arquivos em [dev](../../../dev); `make docker-test` é o alvo básico do Docker, não `make test-docker`.

## Documentação, segurança e licença

- [Exemplos de configuração](../../../docs/README.md)
- [Como contribuir](../../../CONTRIBUTING.md)
- [Política de segurança](../../../SECURITY.md)
- [Licença MIT](../../../LICENSE)
