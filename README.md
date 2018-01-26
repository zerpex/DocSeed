# DocSeed
Your seedbox using docker technology !

## Description :
This script help you building a full-featured seedboxon any debian based distro using docker and docker-compose.

**Proxy :**
- [Traefik](https://github.com/containous/traefik) : Proxy that automatically manage let's encrypt certificates.

**Downloaders :**
- [rTorrent](https://github.com/rakshasa/rtorrent) : **Torrents** downloader with a modern web UI ( [Flood](https://github.com/jfurrow/flood) ). Dockerized by [romancin](https://github.com/romancin/rutorrent-flood-docker).
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
`git clone https://github.com/zerpex/DocSeed.git`

2- Place yourself on the folder :  
`cd DocSeed`

2a- MANDATORY 
- Set `DOMAIN` variable in `config.local` to your domain name.  
- Set your DNS sub-domains (1 per app and according to `config.local`) BEFORE running the script.

2b- OPTIONNAL  
- You can also set container's names in `config.local`.
- (_only if you know what you are doing !_) : You can change all docker options in `./files/includes/*.docker` where "*" is the app you want to change.

3- Execute :  
`./DocSeed.sh`

4- Answer questions :)

## Notes :
- If not found, it will **automatically** install docker and docker-compose.
- Default dirs set to **/home/seedbox**.
- **rTorrent** : user & pass will be asked at first start.
- **SabNZB** : user & pass will be asked at first start.
- **Emby** : user & pass will be asked at first start.
- **Ubooquity** : user & pass will be set on the admin interface on first start.
- **Libresonic** : user : admin | pass : admin
- **Muximux** : user : admin | pass : admin

## To do :
- Add Pyload
- Add Monitoring
