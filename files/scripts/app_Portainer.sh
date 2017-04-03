#!/bin/bash
# Portainer installation


cat files/includes/portainer.docker >> docker-compose.yml

$SUDO sed -i "s@tool-docker_portainer@$Pt_CNAME@g" docker-compose.yml

INSTALLED+=('Pt')
