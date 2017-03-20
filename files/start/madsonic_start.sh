#!/bin/sh

addgroup -g ${GID} madsonic && adduser -h /madsonic -s /bin/sh -D -G madsonic -u ${UID} madsonic

mkdir -p /config/transcode

ln -s /usr/bin/ffmpeg /config/transcode/ffmpeg
ln -s /usr/bin/lame /config/transcode/lame

chown -R madsonic:madsonic /config

sleep 10 # avoid erros

su madsonic << EOF
java -Xmx256m \
  -Dmadsonic.home=/config \
  -Dmadsonic.host=0.0.0.0 \
  -Dmadsonic.port=4040 \
  -Dmadsonic.httpsPort=0 \
  -Dmadsonic.contextPath=$CONTEXT_PATH \
  -Dmadsonic.defaultMusicFolder=/media \
  -Dmadsonic.defaultPodcastFolder=/podcasts \
  -Dmadsonic.defaultPlaylistFolder=/playlists \
  -Djava.awt.headless=true \
  -jar madsonic-booter.jar
