#!/bin/bash

#### MANDATORY ####

#--- Set your domain and email.
DOMAIN=myDomain.tld
MAIL=me@myDomain.tld

#### OPTIONAL ####

#--- Define user and group ID for all apps. Realy important in order to have all apps access the files.
SUID=1069
SGID=1069

#--- Generic vars
TIME_ZONE=Europe/Paris

#--- subdomains per app
Rt_SDOM=rtorrent                 # rTorrent
Sb_SDOM=sabnzb                   # SabNZB
Py_SDOM=pyload                   # Pyload
Rd_SDOM=radarr                   # Radarr
Sg_SDOM=medusa                   # Medusa
Nx_SDOM=nextcloud                # Nextcloud
Hp_SDOM=headphones               # HeadPhones
My_SDOM=mylar                    # Mylar
Eb_SDOM=emby                     # Emby
Ub_SDOM=ubooquity                # Ubooquity
Ua_SDOM=ubooquity-adm            # Ubooquity's admin insterface
Ls_SDOM=libresonic               # Libresonic
Pt_SDOM=portainer                # Portainer
Sy_SDOM=syncthing                # Syncthing
Mx_SDOM=muximux                  # Muximux

#--- Docker options
#- Container names
Rt_CNAME=dl-torrent_rTorrent            # rTorrent
Sb_CNAME=dl-newsgroups_SABnzdb          # SABnzdb
Py_CNAME=dl-directdl_Pyload             # Pyload
Rd_CNAME=autodl-movies_Radarr           # Radarr
Sg_CNAME=autodl-tv_Medusa               # Medusa
Nx_CNAME=cloud-nextcloud                # Nextcloud
Hp_CNAME=autodl-music_Headphones        # HeadPhones
My_CNAME=autodl-comics_Mylar            # Mylar
Eb_CNAME=stream-video_Emby              # Emby
Ub_CNAME=stream-comics_Ubooquity        # Ubooquity
Ls_CNAME=stream-music_Libresonic        # Libresonic
Wt_CNAME=tool-docker_Watchtower         # Watchtower
Pt_CNAME=tool-docker_Portainer          # Portainer
Sy_CNAME=tool-syncro_Syncthing          # Syncthing
Mx_CNAME=tool-manage_Muximux            # Muximux

#--- Define text colors
CSI="\033["
CEND="${CSI}0m"
CRED="${CSI}1;31m"
CGREEN="${CSI}1;32m"
CYELLOW="${CSI}1;33m"
CBLUE="${CSI}1;34m"

#--- Define local system variables
LAN=$(hostname -I | awk '{print $1}')
WAN=$(dig +short myip.opendns.com @resolver1.opendns.com)
FQDN=$(hostname -f)
HNAME=$(hostname)
IFACE=$LAN # default interface 
RDNS=$(dig +short -x $WAN)
RDNS=${RDNS::-1}
DOMAIN="${DOMAIN:-$RDNS}"

#--- Define other used variables
CNAME=_CNAME
CPORT=_CPORT
CSDOM=_SDOM
