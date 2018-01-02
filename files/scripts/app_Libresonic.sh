#!/bin/bash
# Libresonic installation


$SUDO mkdir -p $MEDIA_PATH/sound/music
$SUDO mkdir -p $MEDIA_PATH/sound/podcast
$SUDO mkdir -p $MEDIA_PATH/sound/playlist
$SUDO mkdir -p $MEDIA_PATH/sound/other

cat files/includes/libresonic.docker >> docker-compose.yml

$SUDO sed -i "s@MUSIC@$MEDIA_PATH/sound/music@g" docker-compose.yml
$SUDO sed -i "s@PODCASTS@$MEDIA_PATH/sound/podcast@g" docker-compose.yml
$SUDO sed -i "s@PLAYLISTS@$MEDIA_PATH/sound/playlist@g" docker-compose.yml
$SUDO sed -i "s@MEDIA@$MEDIA_PATH/sound/other@g" docker-compose.yml
$SUDO sed -i "s@stream-music_libresonic@$Ls_CNAME@g" docker-compose.yml

# Set Muximum configuration
cat <<EOF >> files/includes/muximux.conf

[Libresonic]
name = "Libresonic"
url = "http://192.168.42.52:5004"
scale = 1
icon = "muximux-music"
color = "#cc7b19"
enabled = "true"
EOF

$SUDO sed -i "s@192.168.42.52@$IFACE@g" files/includes/muximux.conf

INSTALLED+=('Ls')
