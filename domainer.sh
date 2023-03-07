#!/bin/bash

RED='\033[0;31m'
CYAN='\033[0;36m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\e[93m'
LIGHT_CYAN='\e[96m'

trap 'echo -e "${YELLOW}[${CYAN}i${YELLOW}] User aborted the script"; echo -e "${YELLOW}[${CYAN}i${YELLOW}] Cleaning up"; rm subdomains.txt; exit' INT
banner(){
        clear
	echo -e "${YELLOW}"
	echo '$$$$$$$\                                    $$\'
	echo '$$  __$$\                                   \__|'
	echo '$$ |  $$ | $$$$$$\  $$$$$$\$$$$\   $$$$$$\  $$\ $$$$$$$\   $$$$$$\   $$$$$$\'
	echo '$$ |  $$ |$$  __$$\ $$  _$$  _$$\  \____$$\ $$ |$$  __$$\ $$  __$$\ $$  __$$\'
	echo '$$ |  $$ |$$ /  $$ |$$ / $$ / $$ | $$$$$$$ |$$ |$$ |  $$ |$$$$$$$$ |$$ |  \__|'
	echo '$$ |  $$ |$$ |  $$ |$$ | $$ | $$ |$$  __$$ |$$ |$$ |  $$ |$$   ____|$$ |'
	echo '$$$$$$$  |\$$$$$$  |$$ | $$ | $$ |\$$$$$$$ |$$ |$$ |  $$ |\$$$$$$$\ $$ |'
	echo '\_______/  \______/ \__| \__| \__| \_______|\__|\__|  \__| \_______|\__|'
	echo ""
	echo -e "${YELLOW}[${GREEN}!!!${YELLOW}] ${BLUE}Tool-Name ${YELLOW}: ${CYAN}Domainer"
	echo -e "${YELLOW}[${GREEN}!!!${YELLOW}] ${BLUE}Github    ${YELLOW}: ${CYAN}https://github.com/K3ysTr0K3R"
	echo -e "${YELLOW}[${GREEN}!!!${YELLOW}] ${BLUE}Instagram ${YELLOW}: ${CYAN}1_k3ystr0k3r_1"
	echo -e "${YELLOW}[${GREEN}!!!${YELLOW}] ${BLUE}Coded By  ${YELLOW}: ${CYAN}K3ysTr0K3R"
        echo ""
}
banner
if [ -z "$1" ]; then
        echo -e "${YELLOW}[${GREEN}!${YELLOW}] You must enter a domain name or a keyword"
        echo -e "${YELLOW}[${GREEN}!${YELLOW}] Example Usage${CYAN}: ${BLUE}./domainer.sh (${RED}domain${BLUE}/${RED}keyword${BLUE})"
        exit
fi

echo -e "${YELLOW}[${CYAN}i${YELLOW}] Checking Internet Connection"
wget -q --tries=10 --timeout=5 http://www.google.com -O /tmp/index.google &> /dev/null
if [ ! -s /tmp/index.google ]; then
	echo -e "${YELLOW}[{RED}~{YELLOW}] No Internet Connection Found${CYAN}: ${RED}Failed"
	echo -e "${YELLOW}[{BLUE}?{YELLOW}] Check Your Internet Connection Or Restart${CYAN}: ${BLUE}Domainer"
	exit
else
	echo -e "${YELLOW}[${CYAN}i${YELLOW}] Internet Connection Found${CYAN}: ${BLUE}Proceeding"
fi

sleep 2
banner
echo -e "${YELLOW}[${CYAN}i${YELLOW}] Finding ${RED}$1 ${YELLOW}domains"
assetfinder $1 > subdomains.txt
echo -e "${YELLOW}[${CYAN}i${YELLOW}] Checking if domains are online or offline"
echo ""
while read -r domain; do
	status_code=$(curl -L -s -o /dev/null -w "%{http_code}" $domain)
	if [ "$status_code" -eq 200 ]; then
		echo -e "${YELLOW}[${LIGHT_CYAN}*${YELLOW}] ${LIGHT_CYAN}$domain <------> Online"
	else
		echo -e "${YELLOW}[${RED}~${YELLOW}] ${RED}$domain <------> Offline"
	fi
done < subdomains.txt
echo -e "${YELLOW}[${CYAN}i${YELLOW}] Cleaning up"
rm subdomains.txt
echo -e "${YELLOW}[${BLUE}*${YELLOW}] All done, thanks for using Domainer, ${CYAN}$(whoami)!"
