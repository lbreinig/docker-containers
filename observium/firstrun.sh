#!/bin/bash

atd

# Check if PHP database config exists. If not, copy in the default config
# Ain't nobody got time for this! We're using an external configfile.
# if you need to do something else, configure this part by hand!

# if [ -f /config/config.php ]; then
#   echo "Using existing PHP database config file."
#   echo "/opt/observium/discovery.php -u" | at -M now + 1 minute
# else
#  echo "Loading PHP config from default."
#  mkdir -p /config/databases
#  cp /opt/observium/config.php.default /config/config.php
#  chown nobody:users /config/config.php
#  PW=$(pwgen -1snc 32)
#  sed -i -e 's/PASSWORD/'$PW'/g' /config/config.php
#  sed -i -e 's/USERNAME/observium/g' /config/config.php
# fi

ln -s /config/config.php /opt/observium/config.php
chown nobody:users -R /opt/observium
chmod 755 -R /opt/observium

# enable/start rrdcached
service rrdcached enable
service rrdcached start

# set timezone in php7, if you've passed it to the container.
if [ -f /etc/container_environment/TZ ] ; then
  sed -i "s#\;date\.timezone\ \=#date\.timezone\ \=\ $TZ#g" /etc/php/7.2/cli/php.ini
  sed -i "s#\;date\.timezone\ \=#date\.timezone\ \=\ $TZ#g" /etc/php/7.2/apache2/php.ini
else
  echo "Timezone not specified by environment variable"
  echo UTC > /etc/container_environment/TZ
  sed -i "s#\;date\.timezone\ \=#date\.timezone\ \=\ UTC#g" /etc/php/7.2/cli/php.ini
  sed -i "s#\;date\.timezone\ \=#date\.timezone\ \=\ UTC#g" /etc/php/7.2/apache2/php.ini
fi
