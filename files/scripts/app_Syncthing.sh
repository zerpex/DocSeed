#!/bin/bash
# Syncthing installation

cat files/includes/syncthing.docker >> docker-compose.yml

sed -i "s@FQDN@$Sy_SDOM.$DOMAIN@g" docker-compose.yml
sed -i "s@INCOMING@$INC_PATH@g" docker-compose.yml
sed -i "s@MEDIA@$MEDIA_PATH@g" docker-compose.yml
sed -i "s@tool-syncro_Syncthing@$Sy_CNAME@g" docker-compose.yml

# Set Muximux configuration
cat <<EOF >> files/includes/muximux.conf

[Syncthing]
name = "Syncthing"
url = "https://192.168.42.52"
scale = 1
icon = "muximux-sync"
color = "#3d85c6"
enabled = "true"
dd = "true"
EOF

sed -i "s@192.168.42.52@$Sy_SDOM.$DOMAIN@g" files/includes/muximux.conf
INSTALLED+=('Sy')
