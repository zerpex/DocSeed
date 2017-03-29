#!/bin/bash

#--- Define user and group ID for all apps. Realy important in order to have all apps access the files.
SUID=1069
SGID=1069

#--- Docker options
#- Container names
Rt_CNAME=dl-torrent_rTorrent		# rTorrent
Sb_CNAME=dl-newsgroups_SabnNZB		# SabNZB
Py_CNAME=dl-directdl_Pyload		# Pyload
Rd_CNAME=autodl-movies_Radarr		# Radarr
Sg_CNAME=autodl-tv_SickGear		# SickGear
Hp_CNAME=autodl-music_Headphones	# HeadPhones
My_CNAME=autodl-comics_Mylar		# Mylar
Eb_CNAME=stream-video_Emby		# Emby
Ub_CNAME=stream-comics_Ubooquity	# Ubooquity
Ls_CNAME=stream-music_Libresonic	# Libresonic
Hm_CNAME=tool-manage_HTPCManager	# HTPCManager
Wt_CNAME=tool-docker_Watchtower		# Watchtower
Pt_CNAME=tool-docker_Portainer		# Portainer
Sy_CNAME=tool-syncro_Syncthing          # Syncthing

#- Exposed ports
Rt_CPORT=5001			# rTorrent
Sb_CPORT=5002			# SabNZB
Py_CPORT=5003			# Pyload
Rd_CPORT=5101			# Radarr
Sg_CPORT=5102			# SickGear
Hp_CPORT=5103			# HeadPhones
My_CPORT=5104			# Mylar
Eb_CPORT=5200			# Emby
Ub_CPORT=5201			# Ubooquity
Ls_CPORT=5202			# Libresonic
Hm_CPORT=5555			# HTPCManager
Pt_CPORT=9000			# Portainer
St_CPORT=80                     # Start page
Sy_CPORT=5550                   # Syncthing

#--- Icons for start menu
# (icons from fonts awesome : http://fontawesome.io/icons/ )
Rt_ICON=fa-download             # rTorrent
Sb_ICON=fa-file-archive-o       # SabNZB
Py_ICON=fa-cloud-download       # Pyload
Rd_ICON=fa-file-video-o         # Radarr
Sg_ICON=fa-television           # SickGear
Hp_ICON=fa-file-audio-o         # HeadPhones
My_ICON=fa-comments-o           # Mylar
Eb_ICON=fa-film                 # Emby
Ub_ICON=fa-book                 # Ubooquity
Ls_ICON=fa-music                # Libresonic
Hm_ICON=fa-sign-in              # HTPCManager
Pt_ICON=fa-cubes                # Portainer
Sy_ICON=fa-refresh              # Syncthing

#--- Regroup apps by category
declare -a dl=( 
 Rt Sb Py
)

declare -a autodl=( 
 Rd Sg Hp My
)

declare -a stream=( 
 Eb Ub Ls
)

declare -a tool=( 
 Sy Hm Pt
)

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
