#!/bin/bash

echo "Step 1: Install python tools and packages"
sudo apt-get -y install python-pip python-dev python3-pip python3-dev build-essential
sudo apt-get -y install python-eventlet python-routes python-webob python-paramiko
sudo pip install setuptools --upgrade

echo "Step 2: Clone RYU from git Repo and Installing Ryu"
git clone https://github.com/auntu/ryu.git
cd ryu; #git checkout -b v3.17 v3.17
sudo python ./setup.py install
cd~

echo "Step 3. Install and Update python packages"
sudo pip install six --upgrade
sudo pip install oslo.config msgpack-python
sudo pip install eventlet --upgrade
sudo pip install tinyrpc

echo "Step 4. Test ryu-manager"
cd /home/stack/ryu && git checkout -b v3.17 v3.17
./bin/ryu-manager --version
cd~

#echo "Step 5. Installing Mininet"
#git clone git://github.com/mininet/mininet
#cd mininet; git checkout -b 2.2.1 2.2.1
#./util/install.sh -nf3
#cd~

#echo "Step 6. Testing Mininet"
#sudo mn --test pingall
#sudo mn -c