#!/bin/bash
# Start page installation


cat files/includes/startpage.docker >> docker-compose.yml

$SUDO sed -i "s@55000@$St_CPORT@g" docker-compose.yml

cmd=($DIALOG --title " Select interface " --clear --radiolist "Please select the network interface to use on the start menu: " 20 75 5)
options=("LAN" ": $LAN" on
		 "WAN" ": $WAN\n WARN : start page is not secure.\n If WAN is enabled, don\'t forget to protect it !" off)
choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear

if [ "$choice" == "WAN" ]
then
		IFACE=$WAN
else
		IFACE=$LAN
fi
