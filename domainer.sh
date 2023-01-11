#!/bin/bash

clear
echo ""
echo -e "\e[93m########################"
echo -e "\e[93m# Coded By: K3ysTr0K3R #"
echo -e "\e[93m########################"

if [ -z "$1" ]; then
	echo "[!] Error: You must enter a domain name or a keyword."
	echo "[!] Example Usage: ./domainer.sh (domain/keyword)"
	exit
fi

echo "[i] Finding subdomains for $1 using assetfinder"
assetfinder $1 > subdomains
echo "[i] Checking if subdomains are online or offline"
echo ""
while read -r domain; do
	status_code=$(curl -L -s -o /dev/null -w "%{http_code}" $domain)
	if [ "$status_code" -eq 200 ]; then
		echo -e "\e[96m[*] $domain <------> Online"
	else
		echo -e "\e[91m[~] $domain <------> Offline"
	fi
done < subdomains
echo "[*] Cleaning up"
rm subdomains
echo "[*] All done, thanks for using Domainer, $(whoami)!"

