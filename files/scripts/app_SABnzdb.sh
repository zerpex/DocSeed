#!/bin/bash
# SabNZB installation

cat files/includes/sabnzb.docker >> docker-compose.yml

sed -i "s@FQDN@$Sb_SDOM.$DOMAIN@g" docker-compose.yml
sed -i "s@INCOMING@$INC_PATH@g" docker-compose.yml
sed -i "s@dl-newsgroups_sabnzdb@$Sb_CNAME@g" docker-compose.yml

# Set Muximux configuration
cat <<EOF >> files/includes/muximux.conf

[SABnzbd]
name = "SABnzbd"
url = "https://192.168.42.52"
scale = 1
icon = "muximux-arrow-down"
color = "#f5b907"
enabled = "true"
EOF

sed -i "s@192.168.42.52@$Sb_SDOM.$DOMAIN@g" files/includes/muximux.conf
INSTALLED+=('Sb')
