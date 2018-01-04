#!/bin/bash
# Nextcloud installation

cat files/includes/nextcloud.docker >> docker-compose.yml

$SUDO sed -i "s@DATA@$DEFAULT_PATH/movies@g" docker-compose.yml
$SUDO sed -i "s@FQDN@$Nx_SDOM.$DOMAIN@g" docker-compose.yml
$SUDO sed -i "s@cloud-nextcloud@$Nx_CNAME@g" docker-compose.yml

cat <<EOF >> files/includes/muximux.conf
[Nextcloud]
name = "Nextcloud"
url = "https://192.168.42.52"
scale = 1
icon = "muximux-plex"
color = "#f9be03"
enabled = "true"
EOF

$SUDO sed -i "s@192.168.42.52@$Nx_SDOM.$DOMAIN@g" files/includes/muximux.conf

## Set conf for redis

INSTALLED+=('Nx')
