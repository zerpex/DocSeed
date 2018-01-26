#!/bin/bash
# OpenVPN installation

cat files/includes/openvpn.docker >> docker-compose.yml

OVPN_DATA=$CONF_PATH/openvpn/conf

docker-compose run -v $OVPN_DATA:/etc/openvpn --rm $Ov_CNAME ovpn_genconfig -u udp://$Ov_SDOM.$DOMAIN
docker-compose run -v $OVPN_DATA:/etc/openvpn --rm $Ov_CNAME ovpn_initpki

INSTALLED+=('Ov')
