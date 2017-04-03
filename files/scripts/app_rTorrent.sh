#!/bin/bash
# rTorrent installation


cat files/includes/rtorrent.docker >> docker-compose.yml

$SUDO sed -i "s@INCOMING@$INC_PATH@g" docker-compose.yml
$SUDO sed -i "s@dl-torrent_rtorrent@$Rt_CNAME@g" docker-compose.yml
$SUDO sed -i "s@5001@$Rt_CPORT@g" docker-compose.yml

INSTALLED+=('Rt')
