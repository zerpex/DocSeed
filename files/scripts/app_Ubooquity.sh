#!/bin/bash
# Ubooquity installation


$SUDO mkdir -p $MEDIA_PATH/library

cat files/includes/ubooquity.docker >> docker-compose.yml

$SUDO sed -i "s@LIBRARY@$MEDIA_PATH/library@g" docker-compose.yml
$SUDO sed -i "s@stream-comics_ubooquity@$Ub_CNAME@g" docker-compose.yml
$SUDO sed -i "s@5003@$Ub_CPORT@g" docker-compose.yml

INSTALLED+=('Ub')
