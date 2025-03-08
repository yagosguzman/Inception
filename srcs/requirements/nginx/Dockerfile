FROM debian:bullseye

# We'll update and upgrade apt, and install NGINX, Vim, Curl & OpenSSL
RUN apt update && apt upgrade -y && apt install -y nginx vim curl openssl

# Now we create a directory to store the ssl key and certificate and create the key 
# -x509 type of certificate & -nodes to not set pass
# Lastly we create a directory to store the NGINX config files
RUN	mkdir -p /etc/nginx/ssl && openssl req -x509 -nodes \
	-out /etc/nginx/ssl/nginx.crt \
	-keyout /etc/nginx/ssl/nginx.key \
	-subj "/C=ES/ST=Barcelona/L=Barcelona/O=42/OU=42/CN=ysanchez.42.fr/UID=ysanchez" && \
	mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

RUN mkdir -p /var/www/html

EXPOSE 443

# RUN ln -s /etc/nginx/sites-available/mydefault /etc/nginx/sites-enabled/

# RUN chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]
