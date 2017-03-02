#!/bin/bash

##echo "Step 1. Installing Mininet"
##git clone git://github.com/mininet/mininet
##cd mininet; git checkout -b 2.2.1 2.2.1
##./util/install.sh -nf3
##cd ~
##
##echo "Step 2. Testing Mininet"
##sudo mn --test pingall
##sudo mn -c
##
##sudo apt-get -y install idle
##sudo apt-get -y install wireshark
##sudo wireshark &

echo "Run topology"

read -r -p 'Which topology do you want to run? 1 or 2  -  '
if [[ $REPLY == 1 ]]; then
    sudo python myproj/oneswitchtopo.py
elif [[ $REPLY == 2 ]]; then
    sudo python myproj/twoswitchtopo.py
else
    exit;
fi
