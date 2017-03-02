#!/bin/bash

echo "Step 1: Install python tools and packages"
sudo apt-get -y install python-pip python-dev python3-pip python3-dev build-essential
sudo apt-get -y install python-eventlet python-routes python-webob python-paramiko python-netaddr
sudo pip install setuptools --upgrade

echo "Step 2: Clone RYU from git Repo and Installing Ryu"
git clone --depth=1 https://github.com/auntu/ryu.git
cd /home/stack/ryu && sudo python setup.py install
cd ~

echo "Step 3. Install and Update python packages"
sudo pip install six --upgrade
sudo pip install oslo.config msgpack-python tinyrpc
sudo pip install eventlet --upgrade

echo "Step 4. Test ryu-manager"
cd /home/stack/ryu && ./bin/ryu-manager --version
cd ~
