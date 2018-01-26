#!/bin/bash
# Seedbox manager
#
# author       : zerpex ( zerpex@gmail.com )
# Last updated : 2018 01 02
# Version 1.6
#
# Github : https://github.com/zerpex/seedbox_docker

# Define path
PWD=$(pwd)
SCRPATH=$PWD/files/scripts

# Check if system is debian based
if [ ! -f /etc/debian_version ]; then
    echo -e "${CRED}This script has been writen for Debian-based distros."
    exit 1
fi

# Check if root or sudo:
if [[ $(id -u) -ne 0 ]] ; then 
  echo 'Please run me as root or with sudo'
  exit 1
fi

# Installation pre-requiresites
echo " "
echo -e "${CGREEN}Installing pre-requiresites:$CEND"
echo " "
apt-get update
apt-get -y upgrade
apt-get -y install dialog sudo apt-transport-https ca-certificates curl dnsutils software-properties-common

# Variables includes 
source config.local

# Installation menu begin
if [ -z $DISPLAY ]
   then
      DIALOG=dialog
   else
      DIALOG=Xdialog
fi

if [ ! -z $(docker --version | grep "not found") ]; then
  # OK to check and install docker ?
  $DIALOG --title " IMPORTANT " --clear \
          --yesno "This script require docker and docker-compose, it will install it automatically.\n
                   Do you agree ?" 15 75

  case $? in
       0)# Install docker
	 source $SCRPATH/ins_docker.sh
	
	 # Install docker-compose
	 source $SCRPATH/ins_docker-compose.sh
         ;;
       1)# Can't do anything without docker
         echo "KTHXBYE."
         exit 0
         ;;
  esac
fi
# Define the root path 
D_PATH=($DIALOG --title " Root path " --clear \
             --inputbox "Please set the root path of your installation
( default to /home/seebox ) :" 16 75 "/home/seebox")
DEFAULT_PATH=$("${D_PATH[@]}" 2>&1 >/dev/tty)
# Define the incoming path 
I_PATH=($DIALOG --title " Incoming path " --clear \
        --inputbox "Please set the path of your incoming folder
( default to $DEFAULT_PATH/incoming ) :" 16 75 "$DEFAULT_PATH/incoming")
INC_PATH=$("${I_PATH[@]}" 2>&1 >/dev/tty)
# Define the media path 
M_PATH=($DIALOG --title " Media path " --clear \
        --inputbox "Please set the path of your media folder
( default to $DEFAULT_PATH/media ) :" 16 75 "$DEFAULT_PATH/media")
MEDIA_PATH=$("${M_PATH[@]}" 2>&1 >/dev/tty)
# Define the containers' configuration path 
C_PATH=($DIALOG --title " Configuration path " --clear \
        --inputbox "Please set the path where you want to store apps configuration files
( default to $PWD/files/apps ) :" 16 75 "$PWD/files/apps")
CONF_PATH=$("${C_PATH[@]}" 2>&1 >/dev/tty)

# Create all this directories
mkdir -p $DEFAULT_PATH $INC_PATH $MEDIA_PATH $CONF_PATH
IFACE=$WAN

# Down previously created containers before changing configuration
docker-compose down

# Begin generating docker receipe
cat files/includes/head.docker > docker-compose.yml

# Select apps to install
cmd=(dialog --separate-output --checklist "Select options:" 22 85 16)
options=("Traefik" "Proxy and certificates manager (Mandatory)" on
         "Nextcloud" "Cloud (recommanded)" on
         "Muximux" "Application management console (recommanded)" on
	 "Pyload" "Download : Direct download" off
         "rTorrent-f" "Download : Torrents with flood interface (Choose ONE rtorrent)" off
         "rTorrent-r" "Download : Torrents with rutorrent interface (Choose ONE rtorrent)" off
         "SABnzdb" "Download : Newsgroups" off
         "Emby" "Streaming : Video" off
         "Libresonic" "Streaming : Music" off
         "Ubooquity" "Streaming : Comics" off
         "Radarr" "Automation : Movies" off
         "Medusa" "Automation : TV shows" off
         "Headphones" "Automation : Music" off
         "Mylar" "Automation : Comics" off
	 "VPN" "VPN Server using openvpn" off
         "Watchtower" "Tool : Auto-update apps (Heavily recommanded)" on
         "Portainer" "Tool : Containers management through browser (recomanded)" on
         "Syncthing" "Tool : Devices synchronisation" on)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear

# Install selected apps
for choice in $choices
do
	source $SCRPATH/app_$choice.sh
done

cat files/includes/foot.docker >> docker-compose.yml

# Set global variables
sed -i "s@1069@$SUID@g" docker-compose.yml
sed -i "s@1069@$SGID@g" docker-compose.yml
sed -i "s@CONF@$CONF_PATH@g" docker-compose.yml

# Set permissions
chown -R $SUID:$SGID $DEFAULT_PATH
chown -R $SUID:$SGID $INC_PATH
chown -R $SUID:$SGID $MEDIA_PATH

# Update Muximux conf
mkdir -p $CONF_PATH/muximux/conf/www/muximux
cp files/includes/muximux.conf $CONF_PATH/muximux/conf/www/muximux/settings.ini.php
chown -R $SUID:$SGID $CONF_PATH/muximux/conf/www/muximux/settings.ini.php

# Generate and start all needeed containers
docker network create traefik_proxy
docker-compose up -d
sleep 10

# Writing a beautifull resume
for APP in "${INSTALLED[@]}"
do
	CNAME=_CNAME
	SDOM=_SDOM
	CONTNAME=$(eval "echo \$$APP$CNAME")
	FDOM=$(eval "echo \$$APP$SDOM").$DOMAIN
	FNAME=`echo $CONTNAME | awk -F_ '{print $2}'`
	STATE=`docker inspect -f {{.State.Running}} $CONTNAME`

	if [ "$STATE" == "true" ]
	then
		echo -e "=> [ ${CGREEN}OK$CEND ] $FNAME is now installed and running at ${CYELLOW}https://$FDOM$CEND"
	else
		echo -e "!! [ ${CRED}KO$CEND ] $FNAME is not installed, but not running. Please check logs with "docker logs $CONTNAME" !"
	fi
done

echo " "
echo -e "If you installed Muximux, you can access all your apps directly through : ${CYELLOW}https://$Mx_SDOM.$DOMAIN$CEND"
echo " "
