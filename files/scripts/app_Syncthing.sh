#!/bin/bash
# Syncthing installation


cat files/includes/syncthing.docker >> docker-compose.yml

$SUDO sed -i "s@INCOMING@$INC_PATH@g" docker-compose.yml
$SUDO sed -i "s@MEDIA@$MEDIA_PATH@g" docker-compose.yml
$SUDO sed -i "s@tool-syncro_Syncthing@$Sy_CNAME@g" docker-compose.yml
$SUDO sed -i "s@5550@$Sy_CPORT@g" docker-compose.yml

# Set Muximux configuration
cat <<EOF >> files/includes/muximux.conf

[Syncthing]
name = "Syncthing"
url = "http://192.168.42.52:5550"
scale = 1
icon = "muximux-sync"
color = "#3d85c6"
enabled = "true"
dd = "true"
EOF

$SUDO sed -i "s@192.168.42.52@$IFACE@g" files/includes/muximux.conf
$SUDO sed -i "s@5550@$Sy_CPORT@g" files/includes/muximux.conf

INSTALLED+=('Sy')
