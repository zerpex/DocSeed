#!/bin/bash

rm files/start_menu/www/dl.html files/start_menu/www/autodl.html files/start_menu/www/stream.html files/start_menu/www/tools.html
touch files/start_menu/www/dl.html files/start_menu/www/autodl.html files/start_menu/www/stream.html files/start_menu/www/tools.html

for APP in "${INSTALLED[@]}"
do
        CNAME=_CNAME
        CPORT=_CPORT
        ICON=_ICON
        CONTNAME=$(eval "echo \$$APP$CNAME")
        FPORT=$(eval "echo \$$APP$CPORT")
        FICON=$(eval "echo \$$APP$ICON")
        FNAME=`echo $CONTNAME | awk -F_ '{print $2}'`

        for KEY in "${dl[@]}"
        do
                if [ "$KEY" == "$APP" ]
                then
                        echo "        <a href=\"http://$LAN:$FPORT\" target=\"_blank\" title=\"$FNAME\">" >> files/start_menu/www/dl.html
                        echo "          <i class=\"fa $FICON\"></i>" >> files/start_menu/www/dl.html
                        echo "        </a>" >> files/start_menu/www/dl.html
                fi
        done

        for KEY in "${autodl[@]}"
        do
                if [ "$KEY" == "$APP" ]
                then
                        echo "        <a href=\"http://$LAN:$FPORT\" target=\"_blank\" title=\"$FNAME\">" >> files/start_menu/www/autodl.html
                        echo "          <i class=\"fa $FICON\"></i>" >> files/start_menu/www/autodl.html
                        echo "        </a>" >> files/start_menu/www/autodl.html
                fi
        done

        for KEY in "${stream[@]}"
        do
                if [ "$KEY" == "$APP" ]
                then
                        if [ "$APP" == "Eb" ]
                        then
                                echo "        <a href=\"http://$LAN/emby\" target=\"_blank\" title=\"$FNAME\">" >> files/start_menu/www/stream.html
                                echo "          <i class=\"fa $FICON\"></i>" >> files/start_menu/www/stream.html
                                echo "        </a>" >> files/start_menu/www/stream.html
                        else
                                echo "        <a href=\"http://$LAN:$FPORT\" target=\"_blank\" title=\"$FNAME\">" >> files/start_menu/www/stream.html
                                echo "          <i class=\"fa $FICON\"></i>" >> files/start_menu/www/stream.html
                                echo "        </a>" >> files/start_menu/www/stream.html
                        fi
                fi
        done

        for KEY in "${tool[@]}"
        do
                if [ "$KEY" == "$APP" ]
                then
                        echo "        <a href=\"http://$LAN:$FPORT\" target=\"_blank\" title=\"$FNAME\">" >> files/start_menu/www/tools.html
                        echo "          <i class=\"fa $FICON\"></i>" >> files/start_menu/www/tools.html
                        echo "        </a>" >> files/start_menu/www/tools.html
                fi
        done
done 
