#!/bin/bash
#
# This script installs docker

    $SUDO curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add 
	$SUDO add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
	$SUDO apt-get update
    $SUDO apt-get -y install docker-ce
    $SUDO service docker start
