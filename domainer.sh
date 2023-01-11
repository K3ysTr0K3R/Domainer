#!/bin/bash

trap 'echo "[i] User aborted the script"; echo "[i] Cleaning up"; rm subdomains.txt; exit' INT
clear
banner(){
	echo ""
	echo -e "\e[93m########################"
	echo -e "\e[93m# Coded By: K3ysTr0K3R #"
	echo -e "\e[93m########################"
	echo ""
	echo '$$$$$$$\                                    $$\'
	echo '$$  __$$\                                   \__|'
	echo '$$ |  $$ | $$$$$$\  $$$$$$\$$$$\   $$$$$$\  $$\ $$$$$$$\   $$$$$$\   $$$$$$\'
	echo '$$ |  $$ |$$  __$$\ $$  _$$  _$$\  \____$$\ $$ |$$  __$$\ $$  __$$\ $$  __$$\'
	echo '$$ |  $$ |$$ /  $$ |$$ / $$ / $$ | $$$$$$$ |$$ |$$ |  $$ |$$$$$$$$ |$$ |  \__|'
	echo '$$ |  $$ |$$ |  $$ |$$ | $$ | $$ |$$  __$$ |$$ |$$ |  $$ |$$   ____|$$ |'
	echo '$$$$$$$  |\$$$$$$  |$$ | $$ | $$ |\$$$$$$$ |$$ |$$ |  $$ |\$$$$$$$\ $$ |'
	echo '\_______/  \______/ \__| \__| \__| \_______|\__|\__|  \__| \_______|\__|'
	echo ""
}
banner
echo -e "[!] Checking Internet Connection"
wget -q --tries=10 --timeout=5 http://www.google.com -O /tmp/index.google &> /dev/null
if [ ! -s /tmp/index.google ]; then
	echo -e "[~] No Internet Connection Found: Failed"
	echo -e "[?] Check Your Internet Connection Or Restart: domainer"
	exit
else
	echo -e "[i] Internet Connection Found: Proceeding"
fi

if [ -z "$1" ]; then
	echo "[!] You must enter a domain name or a keyword."
	echo "[!] Example Usage: ./domainer.sh (domain/keyword)"
	exit
fi

echo "[i] Finding domains for $1 using assetfinder"
assetfinder $1 > subdomains.txt
echo "[i] Checking if subdomains are online or offline"
echo ""
while read -r domain; do
	status_code=$(curl -L -s -o /dev/null -w "%{http_code}" $domain)
	if [ "$status_code" -eq 200 ]; then
		echo -e "\e[96m[*] $domain <------> Online"
	else
		echo -e "\e[91m[~] $domain <------> Offline"
	fi
done < subdomains.txt
echo "[i] Cleaning up"
rm subdomains.txt
echo "[*] All done, thanks for using Domainer, $(whoami)!"
