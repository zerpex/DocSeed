#!/bin/bash
# HTPC Manager installation


cat files/includes/htpcmanager.docker >> docker-compose.yml

$SUDO sed -i "s@tool-HTPCManager@$Hm_CNAME@g" docker-compose.yml
$SUDO sed -i "s@5555@$Hm_CPORT@g" docker-compose.yml

INSTALLED+=('Hm')
