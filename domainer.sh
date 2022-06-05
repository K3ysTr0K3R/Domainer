#!/bin/bash

clear

echo -e "\e[93m -------------------------------------- "
echo "| Coded By: K3ysTr0K3R                 |"
echo "|                                      |"
echo "| I am not responsible for any misuse  |"
echo "| of this program.                     |"
echo " -------------------------------------- "

echo " ======== "
echo "|Domainer|"
echo " ======== "

if [ -z "$1" ]; then
	echo "[*] You Must Enter A domain NAME!"
	exit 1
fi

assetfinder $1 > subdomains

for domain in $(cat subdomains); do
	if curl -s $domain &> /dev/null
then
	echo -e "\e[96m[*] $domain <------> {Online}"
else
	echo -e "\e[91m[~] $domain <------> {Offline}"
fi
done

rm subdomains
whoami=$(whoami)

echo "\e[93m[*] All Done $whoami, thanks for using Domainer"
