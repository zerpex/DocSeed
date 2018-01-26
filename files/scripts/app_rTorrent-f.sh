#!/bin/bash
# rTorrent installation

cat files/includes/rtorrent-f.docker >> docker-compose.yml

sed -i "s@FQDN@$Rt_SDOM.$DOMAIN@g" docker-compose.yml
sed -i "s@INCOMING@$INC_PATH@g" docker-compose.yml
sed -i "s@dl-torrent_rtorrent@$Rt_CNAME@g" docker-compose.yml

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

sed -i "s@192.168.42.52@$Rt_SDOM.$DOMAIN@g" files/includes/muximux.conf
mkdir -p $CONF_PATH/rtorrent/conf/
cp files/includes/rtorrent.conf $CONF_PATH/rtorrent/conf/.rtorrent.rc
chown -R $SUID:$SGID $CONF_PATH/rtorrent
INSTALLED+=('Rt')
