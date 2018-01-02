#!/bin/bash
#
# This script installs docker-compose

    $SUDO DOCKER_COMPOSE_VERSION="${DOCKER_COMPOSE_VERSION:-$(curl https://github.com/docker/compose/releases | grep releases/tag | grep -v rc | awk -F">" '{print $2}' | awk -F"<" '{print $1}' | head -1)}"
    $SUDO curl -L https://github.com/docker/compose/releases/download/"$DOCKER_COMPOSE_VERSION"/docker-compose-"$(uname -s)"-"$(uname -m)" > /usr/local/bin/docker-compose
    $SUDO chmod +x /usr/local/bin/docker-compose
