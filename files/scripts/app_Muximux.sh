#!/bin/bash
# Muximux installation

cat files/includes/muximux.docker >> docker-compose.yml

$SUDO sed -i "s@FQDN@$Mx_SDOM.$DOMAIN@g" docker-compose.yml
$SUDO sed -i "s@tool-manage_Muximux@$Mx_CNAME@g" docker-compose.yml
$SUDO sed -i "s@192.168.42.52@$Mx_SDOM.$DOMAIN@g" files/includes/muximux.conf

INSTALLED+=('Mx')
