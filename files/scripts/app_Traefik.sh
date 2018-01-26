#!/bin/bash
# Traefik installation

mkdir -p $CONF_PATH/traefik

TRAEFIK_CONF=$CONF_PATH/traefik/traefik.toml

cp files/includes/traefik.toml $TRAEFIK_CONF
cat files/includes/traefik.docker >> docker-compose.yml

sed -i "s@EMAIL_CH@$MAIL@g" $TRAEFIK_CONF
sed -i "s@domain.tld@$DOMAIN@g" $TRAEFIK_CONF
