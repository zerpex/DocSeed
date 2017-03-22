#!/bin/bash
# Seedbox manager
#
# This script automatically manage some services to any debian based distro.
#      - uTorrent          => Torrents downloader with a modern web UI ( Flood )
#      - SabNZB            => Newsgroups downloader
#      - Emby              => Video streaming platform
#      - Ubooquity         => Comics streaming platform
#      - Libresonic        => Music streaming platform
#      - SickGear          => TV Shows download manager
#
# author       : zerpex ( zerpex@gmail.com )
# Last updated : 2017 03 22
# Version 1.2

#--- Define text colors
CSI="\033["
CEND="${CSI}0m"
CRED="${CSI}1;31m"
CGREEN="${CSI}1;32m"
CYELLOW="${CSI}1;33m"
CBLUE="${CSI}1;34m"

if [ ! -f /etc/debian_version ];
then
        echo -e "${CRED}This script has been writen for Debian-based distros."
        exit 0
fi

echo " "
echo -e "${CYELLOW}This script require docker and docker-compose, it will install it if not found on the system. please quit with CTRL+C if you do not agree.$CEND"
echo " "

sudo addgroup -g 1069 seedbox && sudo adduser -h /home/seedbox --create-home -s /bin/sh -D -G seedbox -u 1069 seedbox

cat files/samples/head.docker > docker-compose.yml
cat files/samples/watchtower.docker >> docker-compose.yml

echo -e "${CYELLOW}Please set the root path of your installation ($CEND${CBLUE}default to /home/seebox$CEND{CYELLOW}) :$CEND"
read DEFAULT_PATH
if [ -z "$DEFAULT_PATH" ]
then
		DEFAULT_PATH=/home/seebox
		sudo mkdir -p $DEFAULT_PATH
		sudo chown -R seedbox:seedbox $DEFAULT_PATH
fi
echo " "
echo -e "${CYELLOW}Please set the path of your incoming folder ($CEND${CBLUE}default to /home/seebox/incoming$CEND{CYELLOW}) :$CEND"
read INC_PATH
if [ -z "$INC_PATH" ]
then
		INC_PATH=$DEFAULT_PATH/incoming
		sudo mkdir -p $INC_PATH
		sudo chown -R seedbox:seedbox $INC_PATH
fi
echo " "
echo -e "${CYELLOW}Please set the path of your media folder ($CEND${CBLUE}default to /home/seebox/media$CEND{CYELLOW}) :$CEND"
read MEDIA_PATH
if [ -z "$MEDIA_PATH" ]
then
		MEDIA_PATH=$DEFAULT_PATH/media
		sudo mkdir -p $MEDIA_PATH
		sudo chown -R seedbox:seedbox $MEDIA_PATH
fi
echo " "
echo -e "${CYELLOW}Do you want to install :$CEND"
echo " "

echo -e "${CBLUE}rTorrent is a lightweight ans stable torrent downloader. Here installed with a modern UI (Flood).$CEND"
echo -e "${CBLUE}Install rTorrent + Flood interface (y/N) ?$CEND"
read rT
if [ "$rT" == "y" ]
then
        sudo mkdir -p $INC_PATH
		cat files/samples/rtorrent.docker >> docker-compose.yml
        sudo sed -i "s@INCOMING@$INC_PATH@g" docker-compose.yml
fi

echo -e "${CBLUE}SabNZB is a newsgroup downloader.$CEND"
echo -e "${CBLUE}Install SabNZB (y/N) ?$CEND"
read Sb
if [ "$Sb" == "y" ]
then
        sudo mkdir -p $INC_PATH
		cat files/samples/sabnzb.docker >> docker-compose.yml
        sudo sed -i "s@INCOMING@$INC_PATH@g" docker-compose.yml
fi

echo -e "${CBLUE}Emby is a media (video/photo/music) streaming plateform.$CEND"
echo -e "${CBLUE}Install emby (y/N) ?$CEND"
read Eb
if [ "$Eb" == "y" ]
then
        sudo mkdir -p $MEDIA_PATH/movies
		cat files/samples/emby.docker >> docker-compose.yml
        sudo sed -i "s@MOVIES@$MEDIA_PATH/movies@g" docker-compose.yml
fi

echo -e "${CBLUE}Ubooquity is a library (comics/ebooks/magazines) streaming plateform.$CEND"
echo -e "${CBLUE}Install ubooquity (y/n) ?$CEND"
read Ub
if [ "$Ub" == "y" ]
then
        sudo mkdir -p $MEDIA_PATH/library
		cat files/samples/ubooquity.docker >> docker-compose.yml
        sudo sed -i "s@LIBRARY@$MEDIA_PATH/library@g" docker-compose.yml
fi

echo -e "${CBLUE}Libresonic is a music streaming plateform.$CEND"
echo -e "${CBLUE}Install libresonic (y/N) ?$CEND"
read Ls
if [ "$Ls" == "y" ]
then
        sudo mkdir -p $MEDIA_PATH/sound/music
		sudo mkdir -p $MEDIA_PATH/sound/podcast
		sudo mkdir -p $MEDIA_PATH/sound/playlist
		sudo mkdir -p $MEDIA_PATH/sound/other
        cat files/samples/libresonic.docker >> docker-compose.yml
        sudo sed -i "s@MUSIC@$MEDIA_PATH/sound/music@g" docker-compose.yml
        sudo sed -i "s@PODCASTS@$MEDIA_PATH/sound/podcast@g" docker-compose.yml
        sudo sed -i "s@PLAYLISTS@$MEDIA_PATH/sound/playlist@g" docker-compose.yml
        sudo sed -i "s@MEDIA@$MEDIA_PATH/sound/other@g" docker-compose.yml
fi

echo -e "${CBLUE}SickGear is a TV shows download manager.$CEND"
echo -e "${CBLUE}Install SickGear (y/N) ?$CEND"
read Sg
if [ "$Sg" == "y" ]
then
        sudo mkdir -p $INC_PATH/tv
        sudo mkdir -p $MEDIA_PATH/tv
        cat files/samples/sickgear.docker >> docker-compose.yml
        sudo sed -i "s@TVINC@$INC_PATH/tv@g" docker-compose.yml
        sudo sed -i "s@TVSHOWS@$MEDIA_PATH/tv@g" docker-compose.yml
fi

echo -e "${CBLUE}Mylar is a comics download manager.$CEND"
echo -e "${CBLUE}Install Mylar (y/N) ?$CEND"
read My
if [ "$My" == "y" ]
then
        sudo mkdir -p $INC_PATH/library
        sudo mkdir -p $MEDIA_PATH/library
        cat files/samples/mylar.docker >> docker-compose.yml
        sudo sed -i "s@BDINC@$INC_PATH/library@g" docker-compose.yml
        sudo sed -i "s@BDS@$MEDIA_PATH/library@g" docker-compose.yml
fi

echo -e "${CBLUE}Headphones is a music download manager.$CEND"
echo -e "${CBLUE}Install Headphones (y/N) ?$CEND"
read Hp
if [ "$Hp" == "y" ]
then
        sudo mkdir -p $INC_PATH/music
        sudo mkdir -p $MEDIA_PATH/sound/music
        cat files/samples/headphones.docker >> docker-compose.yml
        sudo sed -i "s@ZICINC@$INC_PATH/music@g@ docker-compose.yml
        sudo sed -i "s@ZIC@$MEDIA_PATH/sound/music"s@g" docker-compose.yml
fi

echo -e "${CBLUE}Radarr is a movie download manager.$CEND"
echo -e "${CBLUE}Install Radarr (y/N) ?$CEND"
read Rd
if [ "$Sg" == "y" ]
then
        sudo mkdir -p $INC_PATH/movies
        sudo mkdir -p $MEDIA_PATH/movies
        cat files/samples/radarr.docker >> docker-compose.yml
        sudo sed -i "s@MINC@$INC_PATH/movies@g" docker-compose.yml
        sudo sed -i "s@RMOVIES@$MEDIA_PATH/movies@g" docker-compose.yml
fi

cat files/samples/foot.docker >> docker-compose.yml

#######################################################
# Check if docker is installed. If not, install it :) #
#######################################################

if [ ! -s /usr/bin/docker ]
then
        sudo apt-get -y update
        sudo apt-get -y install apt-transport-https ca-certificates curl
        sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
        sudo echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list
        sudo apt-get -y install docker-engine
        sudo service docker start

        sudo curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
        sudo chmod +x /usr/local/bin/docker-compose
fi

docker-compose up -d
