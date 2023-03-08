#!/bin/bash
#
#   ________  ________  ________  ________  ________  ________  ________  ________  ________  ________ 
#  ╱        ╲╱        ╲╱        ╲╱        ╲╱        ╲╱        ╲╱    ╱   ╲╱        ╲╱    ╱   ╲╱        ╲
# ╱         ╱         ╱         ╱         ╱         ╱        _╱         ╱         ╱         ╱        _╱
#╱╱      __╱        _╱         ╱         ╱        _╱╱       ╱╱         ╱        _╱         ╱-        ╱ 
#╲╲_____╱  ╲____╱___╱╲________╱╲__╱__╱__╱╲________╱ ╲______╱ ╲___╱____╱╲________╱╲________╱╲________╱  
# -----------------------------------------------------------------------------------------------------
#                    Copyright © 2022  PROMETHEUS INFORMATION SYSTEMS CORP.
#
#                                       All rights reserved
# -----------------------------------------------------------------------------------------------------

echo ""
read -p "Ready to install Docker? (y/N):  " dockerinstall
dockerinstall=${dockerinstall:-n}
if [ $dockerinstall == y ]
then
var=`date +"%FORMAT_STRING"`
now=`date +"%m_%d_%Y"`
now=`date +"%Y-%m-%d"`
timestamp=`date +"%T"`
echo "$timestamp | Docker install initiated" >> /etc/Firestarter/log/${now}
# Remove any docker install and add the docker repo
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install docker 
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
var=`date +"%FORMAT_STRING"`
now=`date +"%m_%d_%Y"`
now=`date +"%Y-%m-%d"`
timestamp=`date +"%T"`
echo "$timestamp | Docker install completed" >> /etc/Firestarter/log/${now}
else
clear
var=`date +"%FORMAT_STRING"`
now=`date +"%m_%d_%Y"`
now=`date +"%Y-%m-%d"`
timestamp=`date +"%T"`
echo "$timestamp | Docker install skipped" >> /etc/Firestarter/log/${now}
echo "did not install Docker.io" | tr [:lower:] [:upper:] | lolcat -F .0005
echo ""
fi
