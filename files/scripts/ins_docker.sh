#!/bin/bash
#
# This script installs docker

    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add 
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
    apt-get update
    apt-get -y install docker-ce
    service docker start
