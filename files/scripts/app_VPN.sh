#!/bin/bash
# OpenVPN installation

cat files/includes/openvpn.docker >> docker-compose.yml

docker-compose run --rm openvpn ovpn_genconfig -u udp://$Ov_SDOM.$DOMAIN
docker-compose run --rm openvpn ovpn_initpki
