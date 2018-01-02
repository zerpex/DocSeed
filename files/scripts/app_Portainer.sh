#!/bin/bash
# Portainer installation


cat files/includes/portainer.docker >> docker-compose.yml

$SUDO sed -i "s@tool-docker_portainer@$Pt_CNAME@g" docker-compose.yml

# Set Muximum configuration
cat <<EOF >> files/includes/muximux.conf

[Portainer]
name = "Portainer"
url = "http://192.168.42.52:9001"
scale = 1
icon = "muximux-stack"
color = "#6aa84f"
enabled = "true"
dd = "true"
EOF

$SUDO sed -i "s@192.168.42.52@$IFACE@g" files/includes/muximux.conf

INSTALLED+=('Pt')
