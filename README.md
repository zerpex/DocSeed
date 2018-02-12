# DocSeed
Your seedbox using docker technology !

## Description :
This script help you building a full-featured seedboxon any debian based distro using docker and docker-compose.

**Proxy :**
- [Traefik](https://github.com/containous/traefik) : Proxy that automatically manage let's encrypt certificates.

**Downloaders :**
- [Pyload](http://pyload.org/) : **direct download** dockerized by [writl](https://github.com/obi12341/docker-pyload).
- [rTorrent-f](https://github.com/rakshasa/rtorrent) : **Torrents** downloader with a modern web UI ( [Flood](https://github.com/jfurrow/flood) ). Dockerized by [romancin](https://github.com/romancin/rutorrent-flood-docker).
- [rTorrent-r](https://github.com/rakshasa/rtorrent) : **Torrents** downloader with the standard ruttorent web UI. Dockerized by [Xataz](https://github.com/xataz/docker-rtorrent-rutorrent).
- [SabNZB](https://sabnzbd.org/) : **Newsgroups** downloader dockerized by [linuxserver.io](https://github.com/linuxserver/docker-sabnzbd).

**Download automation :**
- [Headphones](https://github.com/rembo10/headphones) : Automated **music** downloader dockerized by [linuxserver.io](https://github.com/linuxserver/docker-headphones).
- [Medusa](https://github.com/pymedusa/Medusa) : Automated **TV Shows** downloader dockerized by [xataz](https://github.com/xataz/docker-medusa).
- [Mylar](https://github.com/evilhero/mylar) : Automated **comic book** (cbr/cbz) downloader dockerized by [linuxserver.io](https://github.com/linuxserver/docker-mylar).  
- [Radarr](https://github.com/Radarr/Radarr) : Automated **movies** downloader dockerized by [linuxserver.io](https://github.com/linuxserver/docker-headphones).

**Streaming :**
- [Emby](https://emby.media/) : Video streaming platform dockerized by [Emby.media](https://hub.docker.com/r/emby/embyserver/).
- [Libresonic](https://github.com/Libresonic/libresonic) : Music streaming platform dockerized by [linuxserver.io](https://github.com/linuxserver/docker-libresonic)
- [Ubooquity](https://vaemendis.net/ubooquity/) : Comics streaming platform dockerized by [myself:)](https://github.com/zerpex/ubooquity-docker).

**Tools :**
- [Muximux](https://github.com/mescon/Muximux) : Front-end interface to manage applications dockerized by [linuxserver.io](https://hub.docker.com/r/linuxserver/muximux/).
- [Nextcloud](https://github.com/nextcloud/server) : Cloud interface dockerized by [hoellen](https://github.com/hoellen/dockerfiles/tree/master/nextcloud).
- [OpenVPN](https://openvpn.net/) : Use your server as a VPN server dockerized by [kylemanna](https://github.com/kylemanna/docker-openvpn)
- [Portainer](https://github.com/portainer/portainer) : **docker tool** that adds a graphical web interface to manage all containers.
- [Syncthing](https://syncthing.net/) : Multiple devices syncronisation tool (servers/smartphone/...) dockerized by [linuxserver.io](https://github.com/linuxserver/docker-syncthing).
- [Watchtower](https://github.com/v2tec/watchtower) : **docker tool** that check and update all other containers automaticaly.

## How to use this script :
1- Clone this repository :  
```bash
git clone https://github.com/zerpex/DocSeed.git
```

2- Place yourself on the folder :  
```bash
cd DocSeed
```

2a- MANDATORY 
- Set `DOMAIN` variable in `config.local` to your domain name.  
- Set your DNS sub-domains (1 per app and according to `config.local`) BEFORE running the script.

2b- OPTIONNAL  
- You can also set container's names in `config.local`.
- (_only if you know what you are doing !_) : You can change all docker options in `./files/includes/*.docker` where "*" is the app you want to change.

3- Execute :  
```bash
./DocSeed.sh
```

4- Answer questions :)

## VPN :

If you installed OpenVPN, you still have to work a little by yourself:

* Generate a client certificate
```bash
export CLIENTNAME="your_client_name"
# with a passphrase (recommended)
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME
# without a passphrase (not recommended)
docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME nopass
```

* Retrieve the client configuration with embedded certificates
```bash
docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn
```

* Revoke a client certificate
```bash
# Keep the corresponding crt, key and req files.
docker-compose run --rm openvpn ovpn_revokeclient $CLIENTNAME
# Remove the corresponding crt, key and req files.
docker-compose run --rm openvpn ovpn_revokeclient $CLIENTNAME remove
```

* Hosts can "see" each others:  
Add the following option in openvpn.conf:
```bash
client-to-client
```

## Notes :
- If not found, it will **automatically** install docker and docker-compose.
- Default dirs set to **/home/seedbox**.
- **Emby** : user & pass will be asked at first start.
- **Libresonic** : user: admin | pass: admin
- **Muximux** : user: admin | pass: admin
- **Pyload** : user: pyload | pass: pyload
- **rTorrent** : user & pass will be asked at first start.
- **SabNZB** : user & pass will be asked at first start.
- **Ubooquity** : user & pass will be set on the admin interface on first start.

## To do :
- Add Pyload
- Add Monitoring
