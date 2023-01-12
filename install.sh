#!/bin/bash

if [ "$EUID" -ne 0 ]; then 
        echo "[!] Run the installation as root"
        exit
fi

apt-get update
apt-get install -y assetfinder

