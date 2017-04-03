#!/bin/bash
# SickGear installation


$SUDO mkdir -p $INC_PATH/tv
$SUDO mkdir -p $MEDIA_PATH/tv

cat files/includes/sickgear.docker >> docker-compose.yml

$SUDO sed -i "s@INCOMING@$INC_PATH/tv@g" docker-compose.yml
$SUDO sed -i "s@TVSHOWS@$MEDIA_PATH/tv@g" docker-compose.yml
$SUDO sed -i "s@autodl-tv_sickgear@$Sg_CNAME@g" docker-compose.yml
$SUDO sed -i "s@5005@$Sg_CPORT@g" docker-compose.yml

INSTALLED+=('Sg')
