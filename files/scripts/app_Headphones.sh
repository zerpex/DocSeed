#!/bin/bash
# Headphones installation


$SUDO mkdir -p $INC_PATH/music
$SUDO mkdir -p $MEDIA_PATH/sound/music

cat files/includes/headphones.docker >> docker-compose.yml

$SUDO sed -i "s@INCOMING@$INC_PATH/music@g" docker-compose.yml
$SUDO sed -i "s@ZIC@$MEDIA_PATH/sound/music@g" docker-compose.yml
$SUDO sed -i "s@autodl-music_headphones@$Hp_CNAME@g" docker-compose.yml
$SUDO sed -i "s@5007@$Hp_CPORT@g" docker-compose.yml

INSTALLED+=('Hp')
