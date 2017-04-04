#!/bin/bash
# Mylar installation


$SUDO mkdir -p $INC_PATH/library
$SUDO mkdir -p $MEDIA_PATH/library

cat files/includes/mylar.docker >> docker-compose.yml

$SUDO sed -i "s@INCOMING@$INC_PATH/library@g" docker-compose.yml
$SUDO sed -i "s@BDS@$MEDIA_PATH/library@g" docker-compose.yml
$SUDO sed -i "s@autodl-comics_mylar@$My_CNAME@g" docker-compose.yml
$SUDO sed -i "s@5006@$My_CPORT@g" docker-compose.yml

# Set Muximum configuration
cat <<EOF >> files/apps/muximux/conf/www/muximux/settings.ini.php

[Mylar]
name = "Mylar"
url = "http://192.168.42.52:5006"
scale = 1
icon = "muximux-book"
color = ""
enabled = "true"
EOF

$SUDO sed -i "s@192.168.42.52@$IFACE@g" files/apps/muximux/conf/www/muximux/settings.ini.php
$SUDO sed -i "s@5006@$My_CPORT@g" files/apps/muximux/conf/www/muximux/settings.ini.php

INSTALLED+=('My')
