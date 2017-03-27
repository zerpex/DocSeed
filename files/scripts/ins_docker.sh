#!/bin/bash
#
# This script installs docker

    $SUDO apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    $SUDO echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list
    $SUDO apt-get -y update
    $SUDO apt-get -y install apt-transport-https ca-certificates curl
    $SUDO apt-get -y install docker-engine
    $SUDO service docker start
