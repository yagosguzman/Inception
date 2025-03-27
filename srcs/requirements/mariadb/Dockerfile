FROM debian:bullseye

# Instala MariaDB correctamente incluyendo los scripts de entrada
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y mariadb-server gettext && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /docker-entrypoint-initdb.d

# Configura permisos
RUN mkdir -p /run/mysqld && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql

# Copia configuración
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# Procesador de variables
COPY tools/init-db.sql /docker-entrypoint-initdb.d/init-db.template

# Script de entrada modificado
RUN echo '#!/bin/bash\nset -e\n\
envsubst < /docker-entrypoint-initdb.d/init-db.template > /docker-entrypoint-initdb.d/init-db.sql\n\
exec mysqld_safe --init-file=/docker-entrypoint-initdb.d/init-db.sql' > /entrypoint.sh && \
    chmod +x /entrypoint.sh

EXPOSE 3306
ENTRYPOINT ["/entrypoint.sh"]
