#!/bin/bash
# Emby installation


$SUDO mkdir -p $MEDIA_PATH/movies

cat files/includes/emby.docker >> docker-compose.yml

$SUDO sed -i "s@MOVIES@$MEDIA_PATH/movies@g" docker-compose.yml
$SUDO sed -i "s@stream-video_emby@$Eb_CNAME@g" docker-compose.yml
$SUDO sed -i "s@5009@$Eb_CPORT@g" docker-compose.yml

INSTALLED+=('Eb')
