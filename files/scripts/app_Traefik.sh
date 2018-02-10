#!/bin/bash
# Traefik installation

cat files/includes/traefik.docker >> docker-compose.yml

sed -i "s/EMAIL_CH/$MAIL/g" docker-compose.yml
sed -i "s@domain.tld@$DOMAIN@g" docker-compose.yml
