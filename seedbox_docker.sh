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
# Last updated : 2017 03 24
# Version 1.3

source vars.sh

if [ ! -f /etc/debian_version ];
then
    echo -e "${CRED}This script has been writen for Debian-based distros."
    exit 0
fi

echo " "
echo -e "${CYELLOW}This script require docker and docker-compose, it will install it if not found on the system. please quit with CTRL+C if you do not agree.$CEND"
echo " "

if [ -f /usr/bin/sudo ]
then
    ROOT=`whoami`
    if [ $ROOT == "root" ]
    then
        SUDO=
    else
        echo -e "${CRED}sudo is not installed on this system and you are not root.$CEND"
        echo -e "${CRED}Please either install sudo or execute this script as root.$CEND"
        exit 1
	fi
else
        SUDO=sudo
fi

cat files/samples/head.docker > docker-compose.yml
cat files/samples/watchtower.docker >> docker-compose.yml
cat files/samples/startpage.docker >> docker-compose.yml

echo -e "${CYELLOW}Please set the root path of your installation ($CEND ${CBLUE}default to /home/seebox$CEND ${CYELLOW}) :$CEND"
read DEFAULT_PATH
if [ -z "$DEFAULT_PATH" ]
then
    DEFAULT_PATH=/home/seebox
    $SUDO mkdir -p $DEFAULT_PATH
fi
echo " "
echo -e "${CYELLOW}Please set the path of your incoming folder ($CEND ${CBLUE}default to /home/seebox/incoming$CEND ${CYELLOW}) :$CEND"
read INC_PATH
if [ -z "$INC_PATH" ]
then
    INC_PATH=$DEFAULT_PATH/incoming
    $SUDO mkdir -p $INC_PATH
fi
echo " "
echo -e "${CYELLOW}Please set the path of your media folder ($CEND ${CBLUE}default to /home/seebox/media$CEND ${CYELLOW}) :$CEND"
read MEDIA_PATH
if [ -z "$MEDIA_PATH" ]
then
    MEDIA_PATH=$DEFAULT_PATH/media
    $SUDO mkdir -p $MEDIA_PATH
fi
echo " "
echo -e "${CYELLOW}Do you want to install :$CEND"
echo " "

echo -e "${CBLUE}rTorrent is a lightweight ans stable torrent downloader. Here installed with a modern UI (Flood).$CEND"
echo -e "${CBLUE}Install rTorrent + Flood interface (y/N) ?$CEND"
read rT
if [ "$rT" == "y" ]
then
    $SUDO mkdir -p $INC_PATH
    cat files/samples/rtorrent.docker >> docker-compose.yml
    $SUDO sed -i "s@INCOMING@$INC_PATH@g" docker-compose.yml
	$SUDO sed -i "s@dl-torrent_rtorrent@$Rt_CNAME@g" docker-compose.yml
	$SUDO sed -i "s@5001@$Rt_CPORT@g" docker-compose.yml
	INSTALLED+=('Rt')
fi

echo -e "${CBLUE}SabNZB is a newsgroup downloader.$CEND"
echo -e "${CBLUE}Install SabNZB (y/N) ?$CEND"
read Sb
if [ "$Sb" == "y" ]
then
    $SUDO mkdir -p $INC_PATH
    cat files/samples/sabnzb.docker >> docker-compose.yml
    $SUDO sed -i "s@INCOMING@$INC_PATH@g" docker-compose.yml
	$SUDO sed -i "s@dl-newsgroups_sabnzdb@$Sb_CNAME@g" docker-compose.yml
	$SUDO sed -i "s@5002@$Sb_CPORT@g" docker-compose.yml
	INSTALLED+=('Sb')
fi

echo -e "${CBLUE}Emby is a media (video/photo/music) streaming plateform.$CEND"
echo -e "${CBLUE}Install emby (y/N) ?$CEND"
read Eb
if [ "$Eb" == "y" ]
then
    $SUDO mkdir -p $MEDIA_PATH/movies
    cat files/samples/emby.docker >> docker-compose.yml
    $SUDO sed -i "s@MOVIES@$MEDIA_PATH/movies@g" docker-compose.yml
	$SUDO sed -i "s@stream-video_emby@$Eb_CNAME@g" docker-compose.yml
	INSTALLED+=('Eb')
fi

echo -e "${CBLUE}Ubooquity is a library (comics/ebooks/magazines) streaming plateform.$CEND"
echo -e "${CBLUE}Install ubooquity (y/n) ?$CEND"
read Ub
if [ "$Ub" == "y" ]
then
    $SUDO mkdir -p $MEDIA_PATH/library
    cat files/samples/ubooquity.docker >> docker-compose.yml
    $SUDO sed -i "s@LIBRARY@$MEDIA_PATH/library@g" docker-compose.yml
	$SUDO sed -i "s@stream-comics_ubooquity@$Ub_CNAME@g" docker-compose.yml
	$SUDO sed -i "s@5003@$Ub_CPORT@g" docker-compose.yml
	INSTALLED+=('Ub')
fi

echo -e "${CBLUE}Libresonic is a music streaming plateform.$CEND"
echo -e "${CBLUE}Install libresonic (y/N) ?$CEND"
read Ls
if [ "$Ls" == "y" ]
then
    $SUDO mkdir -p $MEDIA_PATH/sound/music
    $SUDO mkdir -p $MEDIA_PATH/sound/podcast
    $SUDO mkdir -p $MEDIA_PATH/sound/playlist
    $SUDO mkdir -p $MEDIA_PATH/sound/other
    cat files/samples/libresonic.docker >> docker-compose.yml
    $SUDO sed -i "s@MUSIC@$MEDIA_PATH/sound/music@g" docker-compose.yml
    $SUDO sed -i "s@PODCASTS@$MEDIA_PATH/sound/podcast@g" docker-compose.yml
    $SUDO sed -i "s@PLAYLISTS@$MEDIA_PATH/sound/playlist@g" docker-compose.yml
    $SUDO sed -i "s@MEDIA@$MEDIA_PATH/sound/other@g" docker-compose.yml
	$SUDO sed -i "s@stream-music_libresonic@$Ls_CNAME@g" docker-compose.yml
	$SUDO sed -i "s@5004@$Ls_CPORT@g" docker-compose.yml
	INSTALLED+=('Ls')
fi

echo -e "${CBLUE}SickGear is a TV shows download manager.$CEND"
echo -e "${CBLUE}Install SickGear (y/N) ?$CEND"
read Sg
if [ "$Sg" == "y" ]
then
    $SUDO mkdir -p $INC_PATH/tv
    $SUDO mkdir -p $MEDIA_PATH/tv
    cat files/samples/sickgear.docker >> docker-compose.yml
    $SUDO sed -i "s@TVINC@$INC_PATH/tv@g" docker-compose.yml
    $SUDO sed -i "s@TVSHOWS@$MEDIA_PATH/tv@g" docker-compose.yml
	$SUDO sed -i "s@autodl-movies_sickgear@$Sg_CNAME@g" docker-compose.yml
	$SUDO sed -i "s@5005@$Sg_CPORT@g" docker-compose.yml
	INSTALLED+=('Sg')
fi

echo -e "${CBLUE}Mylar is a comics download manager.$CEND"
echo -e "${CBLUE}Install Mylar (y/N) ?$CEND"
read My
if [ "$My" == "y" ]
then
    $SUDO mkdir -p $INC_PATH/library
    $SUDO mkdir -p $MEDIA_PATH/library
    cat files/samples/mylar.docker >> docker-compose.yml
    $SUDO sed -i "s@BDINC@$INC_PATH/library@g" docker-compose.yml
    $SUDO sed -i "s@BDS@$MEDIA_PATH/library@g" docker-compose.yml
	$SUDO sed -i "s@autodl-comics_mylar@$My_CNAME@g" docker-compose.yml
	$SUDO sed -i "s@5006@$My_CPORT@g" docker-compose.yml
	INSTALLED+=('My')
fi

echo -e "${CBLUE}Headphones is a music download manager.$CEND"
echo -e "${CBLUE}Install Headphones (y/N) ?$CEND"
read Hp
if [ "$Hp" == "y" ]
then
    $SUDO mkdir -p $INC_PATH/music
    $SUDO mkdir -p $MEDIA_PATH/sound/music
    cat files/samples/headphones.docker >> docker-compose.yml
    $SUDO sed -i "s@ZICINC@$INC_PATH/music@g" docker-compose.yml
    $SUDO sed -i "s@ZIC@$MEDIA_PATH/sound/music@g" docker-compose.yml
	$SUDO sed -i "s@autodl-music_headphones@$Hp_CNAME@g" docker-compose.yml
	$SUDO sed -i "s@5007@$Hp_CPORT@g" docker-compose.yml
	INSTALLED+=('Hp')
fi

echo -e "${CBLUE}Radarr is a movie download manager.$CEND"
echo -e "${CBLUE}Install Radarr (y/N) ?$CEND"
read Rd
if [ "$Sg" == "y" ]
then
    $SUDO mkdir -p $INC_PATH/movies
    $SUDO mkdir -p $MEDIA_PATH/movies
    cat files/samples/radarr.docker >> docker-compose.yml
    $SUDO sed -i "s@MINC@$INC_PATH/movies@g" docker-compose.yml
    $SUDO sed -i "s@RMOVIES@$MEDIA_PATH/movies@g" docker-compose.yml
	$SUDO sed -i "s@autodl-movies_radarr@$Rd_CNAME@g" docker-compose.yml
	$SUDO sed -i "s@5008@$Rd_CPORT@g" docker-compose.yml
	INSTALLED+=('Rd')
fi

echo -e "${CBLUE}HTPC Manager is a front-end interface to manage many htpc related applications.$CEND"
echo -e "${CBLUE}Install HTPC Manager (y/N) ?$CEND"
read Hm
if [ "$Hm" == "y" ]
then
    cat files/samples/htpcmanager.docker >> docker-compose.yml
	$SUDO sed -i "s@tool-HTPCManager@$Hm_CNAME@g" docker-compose.yml
	$SUDO sed -i "s@5555@$Hm_CPORT@g" docker-compose.yml
	INSTALLED+=('Hm')
fi

cat files/samples/foot.docker >> docker-compose.yml

$SUDO sed -i "s@1069@$SUID@g" docker-compose.yml
$SUDO sed -i "s@1069@$SGID@g" docker-compose.yml

#######################################################
# Check if docker is installed. If not, install it :) #
#######################################################

if [ ! -s /usr/bin/docker ]
then
    $SUDO apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    $SUDO echo "deb https://apt.dockerproject.org/repo debian-jessie main" > /etc/apt/sources.list.d/docker.list
    $SUDO apt-get -y update
    $SUDO apt-get -y install apt-transport-https ca-certificates curl
    $SUDO apt-get -y install docker-engine
    $SUDO service docker start

    $SUDO curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    $SUDO chmod +x /usr/local/bin/docker-compose
fi

docker-compose up -d

$SUDO chown -R $SUID:$SGID $DEFAULT_PATH
$SUDO chown -R $SUID:$SGID $INC_PATH
$SUDO chown -R $SUID:$SGID $MEDIA_PATH

source files/start_menu/gen_links.sh
