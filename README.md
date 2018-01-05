# seedbox_docker

## Description :
This script automatically install some services to any debian based distro using docker and docker-compose.

**Proxy :**
-[Traefik](https://github.com/containous/traefik) : Proxy that automatically manage let's encrypt certificates.

**Downloaders :**
- [rTorrent](https://github.com/rakshasa/rtorrent) : **Torrents** downloader with a modern web UI ( [Flood](https://github.com/jfurrow/flood) ). Dockerized by [Wonderfall](https://github.com/Wonderfall/dockerfiles/tree/master/rtorrent-flood).
- [SabNZB](https://sabnzbd.org/) : **Newsgroups** downloader dockerized by [linuxserver.io](https://github.com/linuxserver/docker-sabnzbd).
- Pyload : **direct download** not yet implemented. Still looking for a good maintainer.

**Download automation :**
- [Radarr](https://github.com/Radarr/Radarr) : Automated **movies** downloader dockerized by [linuxserver.io](https://github.com/linuxserver/docker-headphones).
- [Medusa](https://github.com/pymedusa/Medusa) : Automated **TV Shows** downloader dockerized by [xataz](https://github.com/xataz/docker-medusa).
- [Headphones](https://github.com/rembo10/headphones) : Automated **music** downloader dockerized by [linuxserver.io](https://github.com/linuxserver/docker-headphones).
- [Mylar](https://github.com/evilhero/mylar) : Automated **comic book** (cbr/cbz) downloader dockerized by [linuxserver.io](https://github.com/linuxserver/docker-mylar).  

**Streaming :**
- [Emby](https://emby.media/) : Video streaming platform dockerized by [Emby.media](https://hub.docker.com/r/emby/embyserver/).
- [Ubooquity](https://vaemendis.net/ubooquity/) : Comics streaming platform dockerized by [myself:)](https://github.com/zerpex/ubooquity-docker).
- [Libresonic](https://github.com/Libresonic/libresonic) : Music streaming platform dockerized by [linuxserver.io](https://github.com/linuxserver/docker-libresonic)

**Tools :**
- [Nextcloud](https://github.com/nextcloud/server) : Cloud interface dockerized by [hoellen](https://github.com/hoellen/dockerfiles/tree/master/nextcloud).
- [Muximux](https://github.com/mescon/Muximux) : Front-end interface to manage applications dockerized by [linuxserver.io](https://hub.docker.com/r/linuxserver/muximux/).
- [Watchtower](https://github.com/v2tec/watchtower) : **docker tool** that check and update all other containers automaticaly.
- [Portainer](https://github.com/portainer/portainer) : **docker tool** that adds a graphical web interface to manage all containers.
- [Syncthing](https://syncthing.net/) : Multiple devices syncronisation tool (servers/smartphone/...) dockerized by [linuxserver.io](https://github.com/linuxserver/docker-syncthing).

## How to use this script :
1- Clone this repository :  
`git clone https://github.com/zerpex/seedbox_docker.git seedbox`

2- Place yourself on the folder :  
`cd seedbox`

2b- OPTIONNAL  
- Container's names and exposed ports are set in var.sh fell free to change them as you like/need :) (just remember that these elements are needeed to be uniq).
- (_only if you know what you are doing !_) : You can change all docker options in `./files/samples/*.docker` where "*" is the app you want to change.

3- Execute :  
`./seedbox_docker.sh`

4- Answer questions :)

## Notes :
- If not found, it will **automatically** install docker and docker-compose
- Default dirs set to /home/seedbox

**rTorrent** : `http://<your-ip>:5001`  
 user and pass will be asked at first start

**SabNZB** : `http://<your-ip>:5002`  
 user and pass will be asked at first start

**Emby** : `http://<your-ip>:5200`  
 user and pass will be asked at first start

**Ubooquity** : `http://<your-ip>:5201`  
 Admin interface is availlable at `htpp://<your-ip>:2502/admin`  
 user and pass will be set on the admin interface on first start.

**Libresonic** : `http://<your-ip>:5202`  
 user : admin / pass : admin

**Radarr** : `http://<your-ip>:5101`

**SickGear** : `http://<your-ip>:5102`

**Headphones** : `http://<your-ip>:5103`

**Mylar** : `http://<your-ip>:5104`

**Muximux** : `http://<your-ip>`  
 user : admin / pass : admin

**Portainer** : `http://<your-ip>:9000`

**Syncthing** : `<your-ip>:5550`

## To do :
- Add a reverse proxy
- Add Pyload
- Add Glances
- Add Pydio
