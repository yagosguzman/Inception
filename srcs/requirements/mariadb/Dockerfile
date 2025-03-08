FROM debian:bullseye

# Update and upgrade apt and install mariadb-server
RUN apt-get update && apt upgrade -y && \
	apt-get install -y mariadb-server

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY /tools/init-db.sh /docker-entrypoint-initdb.d/init-db.sh

RUN chmod +x /docker-entrypoint-initdb.d/init-db.sh