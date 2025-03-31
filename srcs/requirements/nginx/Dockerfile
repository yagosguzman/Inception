FROM debian:bullseye

# We'll update and upgrade apt, and install NGINX, Vim, Curl & OpenSSL
RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx vim curl openssl php-fpm

# Now we create a directory to store the ssl key and certificate and create the key 
# -x509 type of certificate & -nodes to not set pass
# Lastly we create a directory to store the NGINX config files
RUN	mkdir -p /etc/nginx/ssl && openssl req -x509 -nodes \
	-out /etc/nginx/ssl/nginx.crt \
	-keyout /etc/nginx/ssl/nginx.key \
	-subj "/C=ES/ST=Barcelona/L=Barcelona/O=42/OU=42/CN=ysanchez.42.fr/UID=ysanchez" && \
	mkdir -p /var/run/nginx

# Copy the nginx.conf file as the default file
COPY conf/default.conf /etc/nginx/conf.d/default.conf

# We create a folder for the html files
RUN mkdir -p /var/www/html

# Now we expose the port we want to use to communicate
EXPOSE 443

# We change the owner and group of the folder /var/www/html to www-data (Default Nginx user in Debian)
# Also we set permissions for the same folder 
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Default command when the container starts
# Launches Nginx web server in the foreground to prevent the container from exiting
CMD ["nginx", "-g", "daemon off;"]
