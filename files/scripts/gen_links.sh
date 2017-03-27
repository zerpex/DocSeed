#!/bin/bash

rm files/start_menu/www/dl.html files/start_menu/www/autodl.html files/start_menu/www/stream.html files/start_menu/www/tools.html
touch files/start_menu/www/dl.html files/start_menu/www/autodl.html files/start_menu/www/stream.html files/start_menu/www/tools.html

echo " "
echo "#######################"
echo "# Installation Status #"
echo "#######################"
echo " "

for APP in "${INSTALLED[@]}"
do
        CNAME=_CNAME
        CPORT=_CPORT
        ICON=_ICON
        CONTNAME=$(eval "echo \$$APP$CNAME")
        FPORT=$(eval "echo \$$APP$CPORT")
        FICON=$(eval "echo \$$APP$ICON")
        FNAME=`echo $CONTNAME | awk -F_ '{print $2}'`
	STATE=`docker inspect -f {{.State.Running}} $CONTNAME`

        for KEY in "${dl[@]}"
        do
                if [ "$KEY" == "$APP" ]
                then
			echo "        <a href=\"http://$LAN:$FPORT\" target=\"_blank\" title=\"$FNAME\">" >> files/start_menu/www/dl.html
			echo "          <i class=\"fa $FICON\"></i>" >> files/start_menu/www/dl.html
			echo "        </a>" >> files/start_menu/www/dl.html
			if [ "$STATE" == "true" ]
			then
				echo -e "=> [ ${CGREEN}OK$CEND ] $FNAME is now installed and running."
                                echo -e "    Access it directly through : ${CYELLOW}http://$LAN:$FPORT$CEND"
                                echo " "
			else
				echo -e "!! [ ${CRED}KO$CEND ] $FNAME is not installed, but not running. Please check logs with "docker logs $CONTNAME" !"
			fi
                fi
        done

        for KEY in "${autodl[@]}"
        do
                if [ "$KEY" == "$APP" ]
                then
                        echo "        <a href=\"http://$LAN:$FPORT\" target=\"_blank\" title=\"$FNAME\">" >> files/start_menu/www/autodl.html
                        echo "          <i class=\"fa $FICON\"></i>" >> files/start_menu/www/autodl.html
                        echo "        </a>" >> files/start_menu/www/autodl.html
                        if [ "$STATE" == "true" ]
                        then
                                echo -e "=> [ ${CGREEN}OK$CEND ] $FNAME is now installed and running."
                                echo -e "    Access it directly through : ${CYELLOW}http://$LAN:$FPORT$CEND"
                                echo " "
                        else
                                echo -e "!! [ ${CRED}KO$CEND ] $FNAME is not installed, but not running. Please check logs with "docker logs $CONTNAME" !"
                        fi
                fi
        done

        for KEY in "${stream[@]}"
        do
                if [ "$KEY" == "$APP" ]
                then
                        echo "        <a href=\"http://$LAN:$FPORT\" target=\"_blank\" title=\"$FNAME\">" >> files/start_menu/www/stream.html
                        echo "          <i class=\"fa $FICON\"></i>" >> files/start_menu/www/stream.html
                        echo "        </a>" >> files/start_menu/www/stream.html
                        if [ "$STATE" == "true" ]
                        then
                                echo -e "=> [ ${CGREEN}OK$CEND ] $FNAME is now installed and running."
                                echo -e "    Access it directly through : ${CYELLOW}http://$LAN:$FPORT$CEND"
                                echo " "
                        else
                                echo -e "!! [ ${CRED}KO$CEND ] $FNAME is not installed, but not running. Please check logs with "docker logs $CONTNAME" !"
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
                        if [ "$STATE" == "true" ]
                        then
                                echo -e "=> [ ${CGREEN}OK$CEND ] $FNAME is now installed and running. Please configure it trough it's own interface."
                                echo -e "    Access it directly through : ${CYELLOW}http://$LAN:$FPORT$CEND"
                                echo " "
                        else
                                echo -e "!! [ ${CRED}KO$CEND ] $FNAME is not installed, but not running. Please check logs with "docker logs $CONTNAME" !"
                        fi
                fi
        done
done 

echo " "
echo -e "If you installed the start page, you can access all your apps through : ${CYELLOW}http://$LAN:55000$CEND"
echo " "
