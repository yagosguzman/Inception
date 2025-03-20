#!/bin/bash

# Esperar a que la base de datos esté lista
echo "⏳ Esperando a que MariaDB esté lista..."
until mysql -h mariadb -u ${MYSQL_USER} -p${MYSQL_PASSWORD} -e "SELECT 1" >/dev/null 2>&1; do
    sleep 2
done
echo "✅ MariaDB está lista."

# Asegurar permisos de la carpeta
chown -R www-data:www-data /var/www/html

# Si WordPress no está instalado, instalarlo
if [ ! -f "/var/www/html/wordpress/wp-config.php" ]; then
    echo "🌍 Descargando WordPress..."
    wp core download --allow-root

    echo "🔧 Creando configuración de WordPress..."
    wp config create --allow-root \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_PASSWORD} \
        --dbhost=mariadb \
        --path=/var/www/html

    echo "⚡ Instalando WordPress..."
    wp core install --allow-root \
        --url="https://${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}"

    echo "👤 Creando usuario adicional..."
    wp user create --allow-root \
        ${WP_USER} \
        ${WP_USER_EMAIL} \
        --role=author \
        --user_pass=${WP_USER_PASSWORD}

    echo "🎨 Configuraciones adicionales..."
    wp option update blogdescription "Sitio WordPress en Docker" --allow-root
    wp rewrite structure '/%postname%/' --allow-root
    wp option update timezone_string "Europe/Madrid" --allow-root
    wp option update date_format "d/m/Y" --allow-root
    wp option update time_format "H:i" --allow-root
    wp option update permalink_structure "/%postname%/" --allow-root
    wp option update default_comment_status "closed" --allow-root
    wp option update default_ping_status "closed" --allow-root

    echo "🎉 WordPress instalado y configurado correctamente."
else
    echo "✅ WordPress ya estaba instalado."
fi

# Ajustar permisos de nuevo
chown -R www-data:www-data /var/www/html

# Iniciar PHP-FPM en foreground
exec php-fpm7.4 -F