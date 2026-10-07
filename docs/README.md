# MariaDB Role Configuration

Project overview, installation, and limitations: [MariaDB role](../README.md).

## Configuration sources

- [defaults/main.yml](../defaults/main.yml) defines option names and defaults.
- [tasks/main.yml](../tasks/main.yml) defines which optional task files run.
- [templates](../templates) show the generated configuration and scripts.

## Database and user provisioning

After installing the role from source as described in the overview:

```yaml
- hosts: database_servers
  become: true
  vars:
    mariadb_root_password: "{{ vault_mariadb_root_password }}"
    mariadb_databases:
      - name: appdb
        encoding: utf8mb4
        collation: utf8mb4_unicode_ci
    mariadb_users:
      - name: appuser
        password: "{{ vault_appuser_password }}"
        priv: "appdb.*:ALL"
  roles:
    - ansible-role-mariadb
```

Store the referenced values in your existing secret-management system.

## Replication, backups, and monitoring

Review [replication.yml](../tasks/replication.yml) before enabling replication. The checked-in tasks configure primary-side settings and a replication user; they do not supply complete replica initialization or an automatic-failover controller.

Review [backup.yml](../tasks/backup.yml) and the [backup script](../templates/mariadb_backup.sh.j2) together. The presence of backup or encryption options does not establish a tested restore procedure.

[monitoring.yml](../tasks/monitoring.yml) and its templates define the installed exporter and monitoring commands. Configure collection and alerting in the external monitoring system.
