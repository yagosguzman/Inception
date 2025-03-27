#!/bin/bash

docker run -d \
  --name mariadb \
  -e MYSQL_ROOT_PASSWORD=rootpassword \
  -e MYSQL_USER=myuser \
  -e MYSQL_PASSWORD=mypassword \
  -e MYSQL_DATABASE=mydatabase \
  -v $(pwd)/requirements/mariadb/conf/init-db.sql:/docker-entrypoint-initdb.d/init-db.sql \
  -v mariadb_data:/var/lib/mysql \
  -p 3306:3306 \
  mariadb:10.5
