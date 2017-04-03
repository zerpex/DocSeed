#!/bin/bash
# Radarr installation


$SUDO mkdir -p $INC_PATH/movies
$SUDO mkdir -p $MEDIA_PATH/movies

cat files/includes/radarr.docker >> docker-compose.yml

$SUDO sed -i "s@INCOMING@$INC_PATH/movies@g" docker-compose.yml
$SUDO sed -i "s@RMOVIES@$MEDIA_PATH/movies@g" docker-compose.yml
$SUDO sed -i "s@autodl-movies_radarr@$Rd_CNAME@g" docker-compose.yml
$SUDO sed -i "s@5008@$Rd_CPORT@g" docker-compose.yml

INSTALLED+=('Rd')
