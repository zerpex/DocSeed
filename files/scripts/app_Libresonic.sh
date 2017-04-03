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
$SUDO sed -i "s@5004@$Ls_CPORT@g" docker-compose.yml

INSTALLED+=('Ls')
