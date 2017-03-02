#!/bin/bash

echo "Step 1. Installing Mininet"

if ! mn --version &>/dev/null ; then
    if [ ! -d /home/stack/mininet ]; then
        git clone git://github.com/mininet/mininet
    fi
    cd /home/stack/mininet; git checkout -b 2.2.1 2.2.1
    ./util/install.sh -nf3
    cd ~
else
    echo "Mininet already installed"
fi

echo "Step 2. Testing Mininet"
sudo mn --test pingall
sudo mn -c

echo "Step 3. Installing IDLE and Wireshark"
sudo apt-get -y install idle
if ! wireshark --version &>/dev/null ; then sudo apt-get -y install wireshark
fi
sudo wireshark &

echo "Step 4. Running topology"

read -r -p 'Which topology do you want to run? 1 or 2  -  '
if [[ $REPLY == 1 ]]; then
    sudo python myproj/oneswitchtopo.py
elif [[ $REPLY == 2 ]]; then
    sudo python myproj/twoswitchtopo.py
else
    exit;
fi
