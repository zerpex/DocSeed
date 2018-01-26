#!/bin/bash
# Pyload installation

sed -i "s@FQDN@$Pl_SDOM.$DOMAIN@g" docker-compose.yml
sed -i "s@INCOMING@$INC_PATH@g" docker-compose.yml
sed -i "s@dl-ddl_pyload@$Pl_CNAME@g" docker-compose.yml

# Set Muximux configuration
cat <<EOF >> files/includes/muximux.conf

[Pyload]
name = "Pyload"
url = "https://192.168.42.52"
scale = 1
icon = "muximux-rutorrent"
color = "#1a1bfe"
enabled = "true"
EOF

sed -i "s@192.168.42.52@$Pl_SDOM.$DOMAIN@g" files/includes/muximux.conf
INSTALLED+=('Pl')
