#!/bin/bash
# Emby installation


$SUDO mkdir -p $MEDIA_PATH/movies

cat files/includes/emby.docker >> docker-compose.yml

$SUDO sed -i "s@MOVIES@$MEDIA_PATH/movies@g" docker-compose.yml
$SUDO sed -i "s@stream-video_emby@$Eb_CNAME@g" docker-compose.yml

cat <<EOF >> files/includes/muximux.conf

[Emby]
name = "Emby"
url = "http://192.168.42.52:5009"
scale = 1
icon = "muximux-plex"
color = "#f9be03"
enabled = "true"
EOF

$SUDO sed -i "s@192.168.42.52@$IFACE@g" files/includes/muximux.conf

INSTALLED+=('Eb')
