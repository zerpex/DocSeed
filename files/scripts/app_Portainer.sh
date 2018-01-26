#!/bin/bash
# Portainer installation

cat files/includes/portainer.docker >> docker-compose.yml

sed -i "s@FQDN@$Pt_SDOM.$DOMAIN@g" docker-compose.yml
sed -i "s@tool-docker_portainer@$Pt_CNAME@g" docker-compose.yml

# Set Muximum configuration
cat <<EOF >> files/includes/muximux.conf

[Portainer]
name = "Portainer"
url = "https://192.168.42.52"
scale = 1
icon = "muximux-stack"
color = "#6aa84f"
enabled = "true"
dd = "true"
EOF

sed -i "s@192.168.42.52@$Pt_SDOM.$DOMAIN@g" files/includes/muximux.conf
INSTALLED+=('Pt')
