#!/bin/bash
# rTorrent installation


cat files/includes/rtorrent.docker >> docker-compose.yml

$SUDO sed -i "s@FQDN@$Rt_SDOM.$DOMAIN@g" docker-compose.yml
$SUDO sed -i "s@INCOMING@$INC_PATH@g" docker-compose.yml
$SUDO sed -i "s@dl-torrent_rtorrent@$Rt_CNAME@g" docker-compose.yml

# Set Muximux configuration
cat <<EOF >> files/includes/muximux.conf

[rTorrent]
name = "rTorrent"
url = "https://192.168.42.52"
scale = 1
icon = "muximux-rutorrent"
color = "#1a1bfe"
enabled = "true"
EOF

$SUDO sed -i "s@192.168.42.52@$Rt_SDOM.$DOMAIN@g" files/includes/muximux.conf

$SUDO mkdir -p $CONF_PATH/rtorrent/conf/
$SUDO cp files/includes/rtorrent.conf $CONF_PATH/rtorrent/conf/.rtorrent.rc
$SUDO chown -R $SUID:$SGID $CONF_PATH/rtorrent

INSTALLED+=('Rt')
