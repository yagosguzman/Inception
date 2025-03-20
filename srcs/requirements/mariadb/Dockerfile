FROM debian:bullseye

# Update and upgrade apt and install mariadb-server
RUN apt-get update && apt upgrade -y && \
	apt-get install -y mariadb-server

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld && chmod 777 /run/mysqld

# Copy the custom configuration file for our MariaDB and the bash script to execute it
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY /tools/init-db.sql /docker-entrypoint-initdb.d/init-db.sql

# Expose the port we want to use
EXPOSE 3306

RUN chmod +x /docker-entrypoint-initdb.d/init-db.sql

CMD ["bash", "-c", "mysqld --init-file=/docker-entrypoint-initdb.d/init-db.sql"]

# CMD ["mysqld"]