#!/bin/bash

rm dl.html autodl.html stream.html tools.html
touch dl.html autodl.html stream.html tools.html

for APP in "${INSTALLED[@]}"    
do
	CNAME=_CNAME
	CPORT=_CPORT
	CICON=_CICON
	FNAME=`echo "$APP$CNAME"`
	FPORT=`echo "$APP$CPORT"`
	FICON=`echo "$APP$CICON"`
	
	for KEY in "${!dl[@]}"
	do
		if [ "$KEY" == "$APP" ]
		then
			echo "        <a href=\"$LAN:$FPORT\" target=\"_blank\" title=\"$FNAME\" class=\"$FNAME\">" >> dl.html
			echo "          <i class=\"fa $FICON\"></i>" >> dl.html
			echo "        </a>" >> dl.html
		fi
	done

	for KEY in "${!autodl[@]}"
	do
		if [ "$KEY" == "$APP" ]
		then
			echo "        <a href=\"$LAN:$FPORT\" target=\"_blank\" title=\"$FNAME\" class=\"$FNAME\">" >> autodl.html
			echo "          <i class=\"fa $FICON\"></i>" >> autodl.html
			echo "        </a>" >> autodl.html
		fi
	done

	for KEY in "${!stream[@]}"
	do
		if [ "$KEY" == "$APP" ]
		then
			if [ "$APP" == "Eb" ]
			then 
				echo "        <a href=\"$LAN/emby\" target=\"_blank\" title=\"$FNAME\" class=\"$FNAME\">" >> stream.html
				echo "          <i class=\"fa $FICON\"></i>" >> stream.html
				echo "        </a>" >> stream.html
			else
				echo "        <a href=\"$LAN:$FPORT\" target=\"_blank\" title=\"$FNAME\" class=\"$FNAME\">" >> stream.html
				echo "          <i class=\"fa $FICON\"></i>" >> stream.html
				echo "        </a>" >> stream.html
			fi
		fi
	done

	for KEY in "${!tool[@]}"
	do
		if [ "$KEY" == "$APP" ]
		then
			echo "        <a href=\"$LAN:$FPORT\" target=\"_blank\" title=\"$FNAME\" class=\"$FNAME\">" >> tools.html
			echo "          <i class=\"fa $FICON\"></i>" >> tools.html
			echo "        </a>" >> tools.html
		fi
	done
done
