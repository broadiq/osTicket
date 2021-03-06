#!/bin/sh
# (C) BroadIQ, Inc 2018
set -e

# Populate "/data/upload/include/i18n" volume with language packs
if [ ! "$(ls -A /data/upload/include/i18n)" ]; then
    cp -R /data/upload/include/i18n.dist/* /data/upload/include/i18n
    chown -R www-data:www-data /data/upload/include/i18n
fi

# Automate installation
php /data/bin/install.php
echo Applying configuration file security
chmod 644 /data/upload/include/ost-config.php

mkdir -p /run/nginx
chown -R www-data:www-data /run/nginx
chown -R www-data:www-data /var/lib/nginx
mkdir -p /var/log/php
chown -R www-data:www-data /var/log/php

#Launch supervisor to manage processes
exec /usr/bin/supervisord -c /data/supervisord.conf
