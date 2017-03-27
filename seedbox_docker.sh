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
# Last updated : 2017 03 27
# Version 1.4

SCRPATH=files/scripts

source $SCRPATH/vars.sh

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

if [ ! -s /usr/bin/dialog ]
then
	echo " "
	echo -e "${CGREEN}Installing menu pre-requiresites$CEND"
	echo " "
	apt-get -y install dialog
fi

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

cat files/samples/head.docker > docker-compose.yml
	
cmd=(dialog --separate-output --checklist "Select options:" 22 76 16)
options=(01 "rTorrent : Torrents downloads" off
         02 "SabNZB : Newsgroups downloads" off
         03 "Pyload : Direct downloads" off
		 04 "Radarr : Movies automation" off
		 05 "SickGear : TV shows automation" off
		 06 "Headphones : Music automation" off
		 07 "Mylar : Comics automation" off
		 08 "Emby : Video streaming" off
		 09 "Ubooquity : Comics streaming" off
		 10 "Libresonic : Music streaming" off
		 11 "HTPCManager : Automation centrilized interface" off
         12 "Watchtower : Auto-update apps tool (Heavily recommanded)" on
		 13 "Start menu : Web-page that centrilize all links to your apps (heavily recomanded)" on)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
    case $choice in
        01)# rTorrent
			cat files/samples/rtorrent.docker >> docker-compose.yml
			$SUDO sed -i "s@INCOMING@$INC_PATH@g" docker-compose.yml
			$SUDO sed -i "s@dl-torrent_rtorrent@$Rt_CNAME@g" docker-compose.yml
			$SUDO sed -i "s@5001@$Rt_CPORT@g" docker-compose.yml
			INSTALLED+=('Rt')
            ;;
        02)# SabNZB
			cat files/samples/sabnzb.docker >> docker-compose.yml
			$SUDO sed -i "s@INCOMING@$INC_PATH@g" docker-compose.yml
			$SUDO sed -i "s@dl-newsgroups_sabnzdb@$Sb_CNAME@g" docker-compose.yml
			$SUDO sed -i "s@5002@$Sb_CPORT@g" docker-compose.yml
			INSTALLED+=('Sb')
            ;;
        03)# Pyload
            echo "Third Option"
            ;;
        04)#Radarr
            $SUDO mkdir -p $INC_PATH/movies
			$SUDO mkdir -p $MEDIA_PATH/movies
			cat files/samples/radarr.docker >> docker-compose.yml
			$SUDO sed -i "s@MINC@$INC_PATH/movies@g" docker-compose.yml
			$SUDO sed -i "s@RMOVIES@$MEDIA_PATH/movies@g" docker-compose.yml
			$SUDO sed -i "s@autodl-movies_radarr@$Rd_CNAME@g" docker-compose.yml
			$SUDO sed -i "s@5008@$Rd_CPORT@g" docker-compose.yml
			INSTALLED+=('Rd')
            ;;
        05)#SickGear
            $SUDO mkdir -p $INC_PATH/tv
			$SUDO mkdir -p $MEDIA_PATH/tv
			cat files/samples/sickgear.docker >> docker-compose.yml
			$SUDO sed -i "s@TVINC@$INC_PATH/tv@g" docker-compose.yml
			$SUDO sed -i "s@TVSHOWS@$MEDIA_PATH/tv@g" docker-compose.yml
			$SUDO sed -i "s@autodl-movies_sickgear@$Sg_CNAME@g" docker-compose.yml
			$SUDO sed -i "s@5005@$Sg_CPORT@g" docker-compose.yml
			INSTALLED+=('Sg')
            ;;
        06)# Headphones
            $SUDO mkdir -p $INC_PATH/music
			$SUDO mkdir -p $MEDIA_PATH/sound/music
			cat files/samples/headphones.docker >> docker-compose.yml
			$SUDO sed -i "s@ZICINC@$INC_PATH/music@g" docker-compose.yml
			$SUDO sed -i "s@ZIC@$MEDIA_PATH/sound/music@g" docker-compose.yml
			$SUDO sed -i "s@autodl-music_headphones@$Hp_CNAME@g" docker-compose.yml
			$SUDO sed -i "s@5007@$Hp_CPORT@g" docker-compose.yml
			INSTALLED+=('Hp')
            ;;
        07)# Mylar
            $SUDO mkdir -p $INC_PATH/library
			$SUDO mkdir -p $MEDIA_PATH/library
			cat files/samples/mylar.docker >> docker-compose.yml
			$SUDO sed -i "s@BDINC@$INC_PATH/library@g" docker-compose.yml
			$SUDO sed -i "s@BDS@$MEDIA_PATH/library@g" docker-compose.yml
			$SUDO sed -i "s@autodl-comics_mylar@$My_CNAME@g" docker-compose.yml
			$SUDO sed -i "s@5006@$My_CPORT@g" docker-compose.yml
			INSTALLED+=('My')
            ;;
        08)# Emby
            $SUDO mkdir -p $MEDIA_PATH/movies
			cat files/samples/emby.docker >> docker-compose.yml
			$SUDO sed -i "s@MOVIES@$MEDIA_PATH/movies@g" docker-compose.yml
			$SUDO sed -i "s@stream-video_emby@$Eb_CNAME@g" docker-compose.yml
			INSTALLED+=('Eb')
            ;;
        09)# Ubooquity
            $SUDO mkdir -p $MEDIA_PATH/library
			cat files/samples/ubooquity.docker >> docker-compose.yml
			$SUDO sed -i "s@LIBRARY@$MEDIA_PATH/library@g" docker-compose.yml
			$SUDO sed -i "s@stream-comics_ubooquity@$Ub_CNAME@g" docker-compose.yml
			$SUDO sed -i "s@5003@$Ub_CPORT@g" docker-compose.yml
			INSTALLED+=('Ub')
            ;;
        10)# Libresonic
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
            ;;
        11)# HTPCManager
            cat files/samples/htpcmanager.docker >> docker-compose.yml
			$SUDO sed -i "s@tool-HTPCManager@$Hm_CNAME@g" docker-compose.yml
			$SUDO sed -i "s@5555@$Hm_CPORT@g" docker-compose.yml
			INSTALLED+=('Hm')
            ;;
        12)# Watchtower
            cat files/samples/watchtower.docker >> docker-compose.yml
            ;;
		13)# Start menu
            cat files/samples/startpage.docker >> docker-compose.yml
            ;;
    esac
done


cat files/samples/foot.docker >> docker-compose.yml

$SUDO sed -i "s@1069@$SUID@g" docker-compose.yml
$SUDO sed -i "s@1069@$SGID@g" docker-compose.yml

# If docker is not installed
if [ ! -s /usr/bin/docker ]
then
        # Install docker
        source $SCRPATH/ins_docker.sh
fi

# If docker-compose is not installed
if [ ! -s /usr/local/bin/docker-compose ]
then
        # Install docker-compose
        source $SCRPATH/ins_docker-compose.sh
fi

# Set permissions
$SUDO chown -R $SUID:$SGID $DEFAULT_PATH
$SUDO chown -R $SUID:$SGID $INC_PATH
$SUDO chown -R $SUID:$SGID $MEDIA_PATH

# Generate start page links to all installed apps
source $SCRPATH/gen_links.sh

# Generate and start all needeed containers
docker-compose up -d
