#!/bin/bash
#
# This script installs docker-compose

    $SUDO DOCKER_COMPOSE_VERSION="$(curl https://github.com/docker/compose/releases/latest 2> /dev/null | sed 's#.*tag/##;s#">.*##')"
    $SUDO curl -L https://github.com/docker/compose/releases/download/"$DOCKER_COMPOSE_VERSION"/docker-compose-"$(uname -s)"-"$(uname -m)" > /usr/local/bin/docker-compose
    $SUDO chmod +x /usr/local/bin/docker-compose
