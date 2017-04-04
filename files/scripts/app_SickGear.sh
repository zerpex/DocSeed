#!/bin/bash
# SickGear installation


$SUDO mkdir -p $INC_PATH/tv
$SUDO mkdir -p $MEDIA_PATH/tv

cat files/includes/sickgear.docker >> docker-compose.yml

$SUDO sed -i "s@INCOMING@$INC_PATH/tv@g" docker-compose.yml
$SUDO sed -i "s@TVSHOWS@$MEDIA_PATH/tv@g" docker-compose.yml
$SUDO sed -i "s@autodl-tv_sickgear@$Sg_CNAME@g" docker-compose.yml
$SUDO sed -i "s@5005@$Sg_CPORT@g" docker-compose.yml

# Set Muximux configuration
cat <<EOF >> files/apps/muximux/conf/www/muximux/settings.ini.php

[SickGear]
name = "SickGear"
url = "http://192.168.42.52:5005"
scale = 1
icon = "muximux-sickbeard"
color = "#b6f000"
enabled = "true"
EOF

$SUDO sed -i "s@192.168.42.52@$IFACE@g" files/apps/muximux/conf/www/muximux/settings.ini.php
$SUDO sed -i "s@5005@$Sg_CPORT@g" files/apps/muximux/conf/www/muximux/settings.ini.php

INSTALLED+=('Sg')
