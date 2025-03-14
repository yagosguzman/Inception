#!/bin/bash
set -e

# Check if wp-config.php exists, if not we will copy it from local
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "wp-config.php file not found. Copying from host..."
    cp /tmp/wp-config.php /var/www/html/wordpress/wp-config.php
fi

# Double check that permissions are correct
chown www-data:www-data /var/www/html/wordpress/wp-config.php
chmod 644 /var/www/html/wordpress/wp-config.php

# Init PHP-FPM
exec php-fpm7.4 -F
