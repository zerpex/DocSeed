#!/bin/bash
# Seedbox manager
#
# This script automatically manage some services to any debian based distro.
#      - uTorrent	   => Torrents downloader with a modern web UI ( Flood )
#      - SabNZB        => Newsgroups downloader
#      - Emby		   => Video streaming platform
#      - Ubooquity	   => Comics streaming platform
#      - Madsonic	   => Music streaming platform
#
# author       : zerpex ( zerpex@gmail.com )
# Last updated : 2017 03 20
# Version 1

if [ ! -f /etc/debian_version ];
then
	echo " This script has been writen for Debian-based distros."
	exit 0
fi

sudo addgroup -g 1069 seedbox && sudo adduser -h /home/seedbox --create-home -s /bin/sh -D -G seedbox -u 1069 seedbox

echo " "
echo "This script require docker and docker-compose, it will install it if not found on the system. please quit with CTRL+C if you do not agree."
echo " "
echo "Do you want to install : "
echo " "

echo "uTorrent + Flood interface (y/n) ?"
read rT
if [ "$rT" == "y" ]
then
	echo "Path to your torrents incoming folder ( default to /home/seebox/media/incoming ):"
	read rT_INC
	if [ -z "$rT_INC" ]
	then
		rT_INC="/home/seebox/media/incoming"
		mkdir -p $rT_INC
		chown -R seedbox:seedbox $rT_INC
	fi
fi

echo "SabNZB (y/n) ?"
read Sb
then
	echo "Path to your newsgroups incoming folder ( default to /home/seebox/media/incoming ):"
	read Sb_INC
	if [ -z "$Sb_INC" ]
	then
		Sb_INC="/home/seebox/media/incoming"
		mkdir -p $Sb_INC
		chown -R seedbox:seedbox $Sb_INC
	fi
fi

echo "Emby (y/n) ?"
read Eb
then
	echo "Path to your movies ( default to /home/seebox/media/movies ):"
	read Eb_MOVIES
	if [ -z "$Eb_MOVIES" ]
	then
		Eb_MOVIES="/home/seebox/media/movies"
		mkdir -p $Eb_MOVIES
		chown -R seedbox:seedbox $Eb_MOVIES
	fi
fi

echo "Ubooquity (y/n) ?"
read Ub
then
	echo "Path to your library ( default to /home/seebox/media/library ):"
	read Ub_LIBRARY
	if [ -z "$Ub_LIBRARY" ]
	then
		Ub_LIBRARY="/home/seebox/media/library"
		mkdir -p $Ub_LIBRARY
		chown -R seedbox:seedbox $Ub_LIBRARY
	fi
fi

echo "Madsonic (y/n) ?"
read Md
then
	echo "Path to your music ( default to /home/seebox/media/music ):"
	read Md_MUSIC
	if [ -z "$Md_MUSIC" ]
	then
		Md_MUSIC="/home/seebox/media/music"
		mkdir -p $Md_MUSIC
		chown -R seedbox:seedbox $Md_MUSIC
	fi
	echo "Path to your podcasts ( default to /home/seebox/media/podcast ):"
	read Md_PODCAST
	if [ -z "$Md_PODCAST" ]
	then
		Md_PODCAST="/home/seebox/media/podcast"
		mkdir -p $Md_PODCAST
		chown -R seedbox:seedbox $Md_PODCAST
	fi
	echo "Path to your playlists ( default to /home/seebox/media/playlist ):"
	read Md_PLAYLIST
	if [ -z "$Md_PLAYLIST" ]
	then
		Md_PLAYLIST="/home/seebox/media/playlist"
		mkdir -p $Md_PLAYLIST
		chown -R seedbox:seedbox $Md_PLAYLIST
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

if [ "$rT" == "y" ]
then
	cat files/samples/utorrent.docker >> docker-compose.yml
	sudo sed -i 's/INCOMING/'"$rT_INC"'/g' docker-compose.yml
fi

if [ "$Sb" == "y" ]
then
	cat files/samples/sabnzb.docker >> docker-compose.yml
	sudo sed -i 's/INCOMING/'"$Sb_INC"'/g' docker-compose.yml
fi

if [ "$Eb" == "y" ]
then
	cat files/samples/emby.docker >> docker-compose.yml
	sudo sed -i 's/MOVIES/'"$Eb_MOVIES"'/g' docker-compose.yml
fi

if [ "$Ub" == "y" ]
then
	cat files/samples/ubooquity.docker >> docker-compose.yml
	sudo sed -i 's/LIBRARY/'"$Ub_LIBRARY"'/g' docker-compose.yml
fi

if [ "$Md" == "y" ]
then
	cat files/samples/madsonic.docker >> docker-compose.yml
	sudo sed -i 's/MUSIC/'"$Md_MUSIC"'/g' docker-compose.yml
	sudo sed -i 's/PODCASTS/'"$Md_PODCAST"'/g' docker-compose.yml
	sudo sed -i 's/PLAYLISTS/'"$Md_PLAYLISTS"'/g' docker-compose.yml
fi

cat files/samples/foot.docker >> docker-compose.yml

docker-compose up -d
