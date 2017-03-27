#!/bin/bash
#
# This script installs docker-compose

    $SUDO curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    $SUDO chmod +x /usr/local/bin/docker-compose
