#!/bin/bash

trap 'echo "[i] echo "User aborted the script"; echo "[i] Cleaning up" rm subdomains.txt; exit' INT
clear
echo ""
echo -e "\e[93m########################"
echo -e "\e[93m# Coded By: K3ysTr0K3R #"
echo -e "\e[93m########################"

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

