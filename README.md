# seedbox_docker

## Description :
This script automatically install some services to any debian based distro using docker and docker-compose.

**Downloaders :**
- [rTorrent](https://github.com/rakshasa/rtorrent) : Torrents downloader with a modern web UI ( [Flood](https://github.com/jfurrow/flood) ). Dockerized by [Wonderfall](https://github.com/Wonderfall/dockerfiles/tree/master/rtorrent-flood).
- [SabNZB](https://sabnzbd.org/) : Newsgroups downloader dockerized by [linuxserver.io](https://github.com/linuxserver/docker-sabnzbd).

**Download automation :**
- [SickGear](https://github.com/SickGear/SickGear) : Automated TV Shows downloader dockerized by [ressu](https://github.com/SickGear/SickGear.Docker).
- [Headphones](https://github.com/evilhero/mylar) : Automated music downloader dockerized by [linuxserver.io](https://github.com/linuxserver/docker-headphones).
- [Mylar](https://github.com/evilhero/mylar) : Automated Comic Book (cbr/cbz) downloader dockerized by [linuxserver.io](https://github.com/linuxserver/docker-mylar).  

**Streaming :**
- [Emby](https://emby.media/) : Video streaming platform dockerized by [Emby.media](https://hub.docker.com/r/emby/embyserver/).
- [Ubooquity](https://vaemendis.net/ubooquity/) : Comics streaming platform dockerized by [Cromigon](https://github.com/cromigon/ubooquity-docker).
- [Libresonic](https://github.com/Libresonic/libresonic) : Music streaming platform dockerized by [linuxserver.io](https://github.com/linuxserver/docker-libresonic)

**Tools :**
- [Watchtower](https://github.com/v2tec/watchtower) : Check and update all other containers automaticaly.

## How to use this script :
1- Clone this repository :  
`git clone https://github.com/zerpex/seedbox_docker.git seedbox`

2- Place yourself on the folder :  
`cd seedbox`

2b- OPTIONNAL (_and only if you know what you are doing !_)  
- You can change docker options in `./files/samples/*.docker` where "*" is the app you want to change.

3- Execute :  
`./seedbox_docker.sh`

4- Answer questions :)

## Notes :
- If not found, it will automatically install docker and docker-compose
- Default dirs set to /home/seedbox
- Access apps through :

**rTorrent** : `<your-ip>:5001`  
 user and pass will be asked at first start

**SabNZB** : `<your-ip>:5002`  
 user :  
 pass :

**Emby** : `<your-ip>/emby`  
 user and pass will be asked at first start

**Ubooquity** : `<your-ip>:5003`  
 Admin interface is disabled by default for security reasons. In order to set up the application, you have to activate it :
  - Stop Ubooquity container :
`docker stop seedbox_ubooquity`
  - Run the container with admin interface enabled :
`docker run --rm -ti -v /seedbox/docker/files/ubooquity/conf:/opt/ubooquity-data -v /seedbox/librairie:/opt/data -p 5003:2202 cromigon/ubooquity:latest -webadmin`
  - Let it run and open your browser to : `http://<your-ip>:5003/admin`
  - Configure Ubooquity as you wish and close docker (CTRL-Z) in the terminal
  - Restart ubooquity container :
`docker start seedbox_ubooquity`

**Libresonic** : `<your-ip>:5004`  
 user : admin  
 pass : admin

**SickGear** : `<your-ip>:5005`

**Headphones** : `<your-ip>:5006`

**Mylar** : `<your-ip>:5007`

## To do :
- Add a reverse proxy
