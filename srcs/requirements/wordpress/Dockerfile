FROM debian:bullseye

# Update and upgrade apt and install mariadb-server
RUN apt-get update && apt upgrade -y && \
	apt-get install -y vim curl wget php7.4 php7.4-fpm php7.4-mysql mariadb-client

# Download the desired version of Wordpress in the desired folder, decompress it and remove the .tar file
RUN wget https://wordpress.org/wordpress-6.7.2.tar.gz -P /var/www && \
	cd /var/www && tar -xzf wordpress-6.7.2.tar.gz && rm wordpress-6.7.2.tar.gz

# Give root rights to write in the wordpress folder and create the folder to store tmp files(if not created)
RUN chown -R root:root /var/www/wordpress && \
	mkdir -p /run/php

# Again we substitute the .conf file from php so it listens to port 9000
# & "clear_env = no" to keep env variables while php-fpm is being used
COPY /conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

CMD ["php-fpm8.2", "-F"]