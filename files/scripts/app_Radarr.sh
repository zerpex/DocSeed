#!/bin/bash
# Radarr installation

mkdir -p $INC_PATH/movies
mkdir -p $MEDIA_PATH/movies

cat files/includes/radarr.docker >> docker-compose.yml

sed -i "s@FQDN@$Rd_SDOM.$DOMAIN@g" docker-compose.yml
sed -i "s@INCOMING@$INC_PATH/movies@g" docker-compose.yml
sed -i "s@RMOVIES@$MEDIA_PATH/movies@g" docker-compose.yml
sed -i "s@autodl-movies_radarr@$Rd_CNAME@g" docker-compose.yml

# Set Muximux configuration
cat <<EOF >> files/includes/muximux.conf

[Radarr]
name = "Radarr"
url = "https://192.168.42.52"
scale = 1
icon = "muximux-sonarr"
color = "#35c5f4"
enabled = "true"
EOF

sed -i "s@192.168.42.52@$Rd_SDOM.$DOMAIN@g" files/includes/muximux.conf
INSTALLED+=('Rd')
