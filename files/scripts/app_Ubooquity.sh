#!/bin/bash
# Ubooquity installation


$SUDO mkdir -p $MEDIA_PATH/library

cat files/includes/ubooquity.docker >> docker-compose.yml

$SUDO sed -i "s@LIBRARY@$MEDIA_PATH/library@g" docker-compose.yml
$SUDO sed -i "s@stream-comics_ubooquity@$Ub_CNAME@g" docker-compose.yml

# Set Muximux configuration
cat <<EOF >> files/includes/muximux.conf

[Ubooquity]
name = "Ubooquity"
url = "http://192.168.42.52:5003"
scale = 1
icon = "muximux-books"
color = "#3d6fae"
enabled = "true"
EOF

$SUDO sed -i "s@192.168.42.52@$IFACE@g" files/includes/muximux.conf

INSTALLED+=('Ub')
