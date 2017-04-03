#!/bin/bash
# Syncthing installation


cat files/includes/syncthing.docker >> docker-compose.yml

$SUDO sed -i "s@INCOMING@$INC_PATH@g" docker-compose.yml
$SUDO sed -i "s@MEDIA@$MEDIA_PATH@g" docker-compose.yml
$SUDO sed -i "s@tool-syncro_Syncthing@$Sy_CNAME@g" docker-compose.yml
$SUDO sed -i "s@5550@$Sy_CPORT@g" docker-compose.yml

INSTALLED+=('Sy')
