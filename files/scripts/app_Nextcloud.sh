#!/bin/bash
# Nextcloud installation

cat files/includes/nextcloud.docker >> docker-compose.yml

sed -i "s@DATASTORE@$DEFAULT_PATH@g" docker-compose.yml
sed -i "s@FQDN@$Nx_SDOM.$DOMAIN@g" docker-compose.yml
sed -i "s@cloud-nextcloud@$Nx_CNAME@g" docker-compose.yml

cat <<EOF >> files/includes/muximux.conf
[Nextcloud]
name = "Nextcloud"
url = "https://192.168.42.52"
scale = 1
icon = "muximux-plex"
color = "#f9be03"
enabled = "true"
EOF

sed -i "s@192.168.42.52@$Nx_SDOM.$DOMAIN@g" files/includes/muximux.conf

## Set conf for redis
NEXTCLOUD_CONF=$CONF/files/apps/nextcloud/conf/config.php
sed -i '$ d' $NEXTCLOUD_CONF
cat >> $NEXTCLOUD_CONF <<- EOM
'memcache.distributed' => '\OC\Memcache\Redis',
'memcache.locking' => '\OC\Memcache\Redis',
'memcache.local' => '\OC\Memcache\APCu',
'redis' => array(
   'host' => 'redis',
   'port' => 6379,
   ),
);
EOM

INSTALLED+=('Nx')
