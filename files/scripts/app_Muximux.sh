#!/bin/bash
# Muximux installation


cat files/includes/muximux.docker >> docker-compose.yml

$SUDO sed -i "s@tool-manage_Muximux@$Mx_CNAME@g" docker-compose.yml
$SUDO sed -i "s@5554@$Mx_CPORT@g" docker-compose.yml
$SUDO sed -i "s@192.168.42.52@$IFACE@g" files/apps/muximux/conf/www/muximux/settings.ini.php

INSTALLED+=('Mx')
