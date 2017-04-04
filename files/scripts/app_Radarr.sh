#!/bin/bash
# Radarr installation


$SUDO mkdir -p $INC_PATH/movies
$SUDO mkdir -p $MEDIA_PATH/movies

cat files/includes/radarr.docker >> docker-compose.yml

$SUDO sed -i "s@INCOMING@$INC_PATH/movies@g" docker-compose.yml
$SUDO sed -i "s@RMOVIES@$MEDIA_PATH/movies@g" docker-compose.yml
$SUDO sed -i "s@autodl-movies_radarr@$Rd_CNAME@g" docker-compose.yml
$SUDO sed -i "s@5008@$Rd_CPORT@g" docker-compose.yml

# Set Muximux configuration
cat <<EOF >> files/apps/muximux/conf/www/muximux/settings.ini.php

[Radarr]
name = "Radarr"
url = "http://192.168.42.52:5008"
scale = 1
icon = "muximux-sonarr"
color = "#35c5f4"
enabled = "true"
EOF

$SUDO sed -i "s@192.168.42.52@$IFACE@g" files/apps/muximux/conf/www/muximux/settings.ini.php
$SUDO sed -i "s@5008@$Rd_CPORT@g" files/apps/muximux/conf/www/muximux/settings.ini.php

INSTALLED+=('Rd')
