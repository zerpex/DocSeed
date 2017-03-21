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
# Last updated : 2017 03 21
# Version 1.1

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

sudo addgroup -g 1069 seedbox && sudo adduser -h /home/seedbox --create-home -s /bin/sh -D -G seedbox -u 1069 seedbox

echo " "
echo -e "${CYELLOW}This script require docker and docker-compose, it will install it if not found on the system. please quit with CTRL+C if you do not agree.$CEND"
echo " "
echo -e "${CYELLOW}Do you want to install :$CEND"
echo " "

echo -e "${CBLUE}uTorrent + Flood interface (y/n) ?$CEND"
read rT
if [ "$rT" == "y" ]
then
        echo -e "${CGREEN}Path to your torrents incoming folder ( default to /home/seebox/media/incoming ):$CEND"
        read rT_INC
        if [ -z "$rT_INC" ]
        then
                rT_INC="/home/seebox/media/incoming"
                mkdir -p $rT_INC
                chown -R seedbox:seedbox $rT_INC
        fi
fi

echo -e "${CBLUE}SabNZB (y/n) ?$CEND"
read Sb
if [ "$Sb" == "y" ]
then
        echo -e "${CGREEN}Path to your newsgroups incoming folder ( default to /home/seebox/media/incoming ):$CEND"
        read Sb_INC
        if [ -z "$Sb_INC" ]
        then
                Sb_INC="/home/seebox/media/incoming"
                mkdir -p $Sb_INC
                chown -R seedbox:seedbox $Sb_INC
        fi
fi

echo -e "${CBLUE}Emby (y/n) ?$CEND"
read Eb
if [ "$Eb" == "y" ]
then
        echo -e "${CGREEN}Path to your movies ( default to /home/seebox/media/movies ):$CEND"
        read Eb_MOVIES
        if [ -z "$Eb_MOVIES" ]
        then
                Eb_MOVIES="/home/seebox/media/movies"
                mkdir -p $Eb_MOVIES
                chown -R seedbox:seedbox $Eb_MOVIES
        fi
fi

echo -e "${CBLUE}Ubooquity (y/n) ?$CEND"
read Ub
if [ "$Ub" == "y" ]
then
        echo -e "${CGREEN}Path to your library ( default to /home/seebox/media/library ):$CEND"
        read Ub_LIBRARY
        if [ -z "$Ub_LIBRARY" ]
        then
                Ub_LIBRARY="/home/seebox/media/library"
                mkdir -p $Ub_LIBRARY
                chown -R seedbox:seedbox $Ub_LIBRARY
        fi
fi

echo -e "${CBLUE}Libresonic (y/n) ?$CEND"
read Ls
if [ "$Ls" == "y" ]
then
        echo -e "${CGREEN}Path to your music ( default to /home/seebox/media/music ):$CEND"
        read Ls_MUSIC
        if [ -z "$Ls_MUSIC" ]
        then
                Ls_MUSIC="/home/seebox/media/music"
                mkdir -p $Ls_MUSIC
                chown -R seedbox:seedbox $Ls_MUSIC
        fi
        echo -e "${CGREEN}Path to your podcasts ( default to /home/seebox/media/podcast ):$CEND"
        read Ls_PODCAST
        if [ -z "$Ls_PODCAST" ]
        then
                Ls_PODCAST="/home/seebox/media/podcast"
                mkdir -p $Ls_PODCAST
                chown -R seedbox:seedbox $Ls_PODCAST
        fi
        echo -e "${CGREEN}Path to your playlists ( default to /home/seebox/media/playlist ):$CEND"
        read Ls_PLAYLIST
        if [ -z "$Ls_PLAYLIST" ]
        then
                Ls_PLAYLIST="/home/seebox/media/playlist"
                mkdir -p $Ls_PLAYLIST
                chown -R seedbox:seedbox $Ls_PLAYLIST
        fi
        echo -e "${CGREEN}Path to your other media ( default to /home/seebox/media/other ):$CEND"
        read Ls_OTHER
        if [ -z "$Ls_OTHER" ]
        then
                Ls_OTHER="/home/seebox/media/other"
                mkdir -p $Ls_OTHER
                chown -R seedbox:seedbox $Ls_OTHER
        fi
fi

echo -e "${CBLUE}SickGear (y/n) ?$CEND"
read Sg
if [ "$Sg" == "y" ]
then
        echo -e "${CGREEN}Path to your TV Shows incoming folder ( default to /home/seebox/media/incoming ):$CEND"
        read Sg_TVINC
        if [ -z "$Sg_TVINC" ]
        then
                Sg_TVINC="/home/seebox/media/incoming"
                mkdir -p $Sg_TVINC
                chown -R seedbox:seedbox $Sg_TVINC
        fi
        echo -e "${CGREEN}Path to your TV Shows ( default to /home/seebox/media/TV ):$CEND"
        read Sg_TVSHOWS
        if [ -z "$Sg_TVSHOWS" ]
        then
                Sg_TVSHOWS="/home/seebox/media/TV"
                mkdir -p $Sg_TVSHOWS
                chown -R seedbox:seedbox $Sg_TVSHOWS
        fi
fi

echo "Mylar (y/n) ?"
read My
then
        echo "Path to your Comics incoming folder ( default to /home/seebox/media/incoming ):"
        read My_BDINC
        if [ -z "$My_BDINC" ]
        then
                My_BDINC="/home/seebox/media/incoming"
                mkdir -p $My_BDINC
                chown -R seedbox:seedbox $My_BDINC
        fi
        echo "Path to your Comics ( default to /home/seebox/media/comics ):"
        read My_BDS
        if [ -z "$My_BDS" ]
        then
                My_BDS="/home/seebox/media/comics"
                mkdir -p $My_BDS
                chown -R seedbox:seedbox $My_BDS
        fi
fi

echo "Headphones (y/n) ?"
read Hp
then
        echo "Path to your Comics incoming folder ( default to /home/seebox/media/incoming ):"
        read Hp_ZICINC
        if [ -z "$Hp_ZICINC" ]
        then
                Hp_ZICINC="/home/seebox/media/incoming"
                mkdir -p $Hp_ZICINC
                chown -R seedbox:seedbox $Hp_ZICINC
        fi
        echo "Path to your Comics ( default to /home/seebox/media/comics ):"
        read Hp_ZIC
        if [ -z "$Hp_ZIC" ]
        then
                Hp_ZIC="/home/seebox/media/comics"
                mkdir -p $Hp_ZIC
                chown -R seedbox:seedbox $Hp_ZIC
        fi
fi

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

cat files/samples/head.docker > docker-compose.yml
cat files/samples/watchtower.docker > docker-compose.yml

if [ "$rT" == "y" ]
then
        cat files/samples/rtorrent.docker >> docker-compose.yml
		sudo sed -i "s@INCOMING@$rT_INC@g" docker-compose.yml
fi

if [ "$Sb" == "y" ]
then
        cat files/samples/sabnzb.docker >> docker-compose.yml
		sudo sed -i "s@INCOMING@$Sb_INC@g" docker-compose.yml
fi

if [ "$Eb" == "y" ]
then
        cat files/samples/emby.docker >> docker-compose.yml
		sudo sed -i "s@MOVIES@$Eb_MOVIES@g" docker-compose.yml
fi

if [ "$Ub" == "y" ]
then
        cat files/samples/ubooquity.docker >> docker-compose.yml
		sudo sed -i "s@LIBRARY@$Ub_LIBRARY@g" docker-compose.yml
fi

if [ "$Ls" == "y" ]
then
        cat files/samples/libresonic.docker >> docker-compose.yml
		sudo sed -i "s@MUSIC@$Ls_MUSIC@g" docker-compose.yml
		sudo sed -i "s@PODCASTS@$Ls_PODCAST@g" docker-compose.yml
		sudo sed -i "s@PLAYLISTS@$Ls_PLAYLISTS@g" docker-compose.yml
		sudo sed -i "s@MEDIA@$Ls_OTHER@g" docker-compose.yml
fi

if [ "$Sg" == "y" ]
then
        cat files/samples/sickgear.docker >> docker-compose.yml
        sudo sed -i "s@TVINC@$Sg_TVINC@g" docker-compose.yml
	sudo sed -i "s@TVSHOWS@$Sg_TVSHOWS@g" docker-compose.yml
fi

if [ "$My" == "y" ]
then
        cat files/samples/mylar.docker >> docker-compose.yml
        sudo sed -i 's/BDINC/'"$My_BDINC"'/g' docker-compose.yml
        sudo sed -i 's/BDS/'"$My_BDS"'/g' docker-compose.yml
fi

if [ "$Hp" == "y" ]
then
        cat files/samples/headphones.docker >> docker-compose.yml
        sudo sed -i 's/ZICINC/'"$Hp_ZICINC"'/g' docker-compose.yml
        sudo sed -i 's/ZIC/'"$Hp_ZIC"'/g' docker-compose.yml
fi

cat files/samples/foot.docker >> docker-compose.yml

docker-compose up -d
