#!/bin/bash
# Emby installation

mkdir -p $MEDIA_PATH/movies

cat files/includes/emby.docker >> docker-compose.yml

sed -i "s@MOVIES@$MEDIA_PATH/movies@g" docker-compose.yml
sed -i "s@FQDN@$Eb_SDOM.$DOMAIN@g" docker-compose.yml
sed -i "s@stream-video_emby@$Eb_CNAME@g" docker-compose.yml

cat <<EOF >> files/includes/muximux.conf

[Emby]
name = "Emby"
url = "https://192.168.42.52"
scale = 1
icon = "muximux-plex"
color = "#f9be03"
enabled = "true"
EOF

sed -i "s@192.168.42.52@$Eb_SDOM.$DOMAIN@g" files/includes/muximux.conf
INSTALLED+=('Eb')
