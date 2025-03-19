FROM debian:bullseye

# Update and upgrade apt and install mariadb-server
RUN apt-get update && apt upgrade -y && \
	apt-get install -y mariadb-server

# Copy the custom configuration file for our MariaDB and the bash script to execute it
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY /tools/init-db.sh /docker-entrypoint-initdb.d/init-db.sh

# Expose the port we want to use
EXPOSE 3306

RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh

CMD ["mysqld"]