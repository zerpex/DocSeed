#!/bin/bash
# Traefik installation

mkdir -p $CONF_PATH/traefik

cp files/includes/traefik.toml $CONF_PATH/traefik/traefik.toml
cat files/includes/traefik.docker >> docker-compose.yml
