FROM debian:bullseye
 
RUN apt update && apt upgrade -y && apt install -y nginx vim curl openssl && \
	mkdir -p /etc/nginx/ssl && \
	openssl req -x509 -nodes \
	-out /etc/nginx/ssl/nginx.crt \
	-keyout /etc/nginx/ssl/nginx.key \
	-subj "/C=ES/ST=IDF/L=Barcelona/O=42/OU=42/CN=ysanchez.42.fr/UID=ysanchez" && \
	mkdir -p /var/run/nginx

COPY conf/nginx.conf /etc/nginx/sites-available/mydefault
RUN ln -s /etc/nginx/sites-available/mydefault /etc/nginx/sites-enabled/

RUN chmod 755 /var/www/html && chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]
