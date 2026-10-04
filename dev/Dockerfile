FROM mariadb:13.0

LABEL maintainer="Thomas Vincent"
LABEL description="MariaDB with Ansible role pre-configured"

# Set environment variables
ENV MARIADB_ROOT_PASSWORD=root
ENV MARIADB_DATABASE=default_db
ENV MARIADB_USER=dbuser
ENV MARIADB_PASSWORD=dbpassword

# Copy custom configuration
COPY templates/mariadb.cnf.j2 /etc/mysql/mariadb.conf.d/99-custom.cnf

# Expose port
EXPOSE 3306

# Set volume
VOLUME ["/var/lib/mysql"]

# Health check
HEALTHCHECK --interval=10s --timeout=5s --start-period=30s --retries=3 \
  CMD mariadb -uroot -p${MARIADB_ROOT_PASSWORD} -e "SELECT 1;" || exit 1
