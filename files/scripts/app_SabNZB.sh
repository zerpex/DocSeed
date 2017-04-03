#!/bin/bash
# SabNZB installation


cat files/includes/sabnzb.docker >> docker-compose.yml

$SUDO sed -i "s@INCOMING@$INC_PATH@g" docker-compose.yml
$SUDO sed -i "s@dl-newsgroups_sabnzdb@$Sb_CNAME@g" docker-compose.yml
$SUDO sed -i "s@5002@$Sb_CPORT@g" docker-compose.yml

INSTALLED+=('Sb')
