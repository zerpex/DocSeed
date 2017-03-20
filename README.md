# seedbox_docker

## Description :
This script automatically install some services to any debian based distro using docker and docker-compose.
- uTorrent	   => Torrents downloader with a modern web UI ( Flood )
- SabNZB             => Newsgroups downloader
- Emby	           => Video streaming platform
- Ubooquity	   => Comics streaming platform
- Libresonic	   => Music streaming platform 

## Use :
| 1- Clone this repository :
| `git clone https://github.com/zerpex/seedbox_docker.git seedbox`

| 2- Execute :
| `./seedbox_docker.sh`

## Notes :
- If not found, it will automatically install docker and docker-compose
- Default dirs set to /home/seedbox

**uTorrent** : `<your-ip>:5001`
 user and pass will be asked at first start

**SabNZB** : `<your-ip>:5002`
 user :
 pass :

**Emby** : `<your-ip>/emby`
 user and pass will be asked at first start

**Ubooquity** : `<your-ip>:5003`
 Admin interface is disabled by default for security reasons. In order to set up the application, you have to activate it :
```
docker stop seedbox_ubooquity
docker run --rm -ti -v /seedbox/docker/files/ubooquity/conf:/opt/ubooquity-data -v /seedbox/librairie:/opt/data -p 5003:2202 cromigon/ubooquity:latest -webadmin
```
  - Let it run and open your browser to : http://<your-ip>:5003/admin
  - Configure Ubooquity as you wish and close docker (CTRL-Z) in the terminal
  - Restart ubooquity container :
```
docker start seedbox_ubooquity
```

**Libresonic** : `<your-ip>:5004`
 user : admin
 pass : admin

## To do :
- Add a reverse proxy
