#!/bin/bash
# Mylar installation


$SUDO mkdir -p $INC_PATH/library
$SUDO mkdir -p $MEDIA_PATH/library

cat files/includes/mylar.docker >> docker-compose.yml

$SUDO sed -i "s@INCOMING@$INC_PATH/library@g" docker-compose.yml
$SUDO sed -i "s@BDS@$MEDIA_PATH/library@g" docker-compose.yml
$SUDO sed -i "s@autodl-comics_mylar@$My_CNAME@g" docker-compose.yml
$SUDO sed -i "s@5006@$My_CPORT@g" docker-compose.yml

INSTALLED+=('My')
