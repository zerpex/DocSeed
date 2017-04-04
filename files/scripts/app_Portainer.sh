#!/bin/bash
# Portainer installation


cat files/includes/portainer.docker >> docker-compose.yml

$SUDO sed -i "s@tool-docker_portainer@$Pt_CNAME@g" docker-compose.yml
$SUDO sed -i "s@9000@Pt_CPORT@g" docker-compose.yml

# Set Muximum configuration
cat <<EOF >> files/apps/muximux/conf/www/muximux/settings.ini.php

[Portainer]
name = "Portainer"
url = "http://192.168.42.52:9000"
scale = 1
icon = "muximux-stack"
color = "#6aa84f"
enabled = "true"
dd = "true"
EOF

$SUDO sed -i "s@192.168.42.52@$IFACE@g" files/apps/muximux/conf/www/muximux/settings.ini.php
$SUDO sed -i "s@9000@Pt_CPORT@g" files/apps/muximux/conf/www/muximux/settings.ini.php

INSTALLED+=('Pt')
