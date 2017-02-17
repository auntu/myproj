#!/bin/bash

if [[ $(whoami)  != 'root' ]]; then
#	echo "Run as root";
	echo "-------------------------------"
	echo "		Run as root	     "
	echo "-------------------------------"
	exit;
else
	echo "-------------------------------"
	echo "	      Running as root	     "
	echo "-------------------------------"
fi

echo "Step 1: Updating and upgrading Ubuntu OS"
apt-get update -y && apt-get upgrade -y

echo "Step 2: Adding stack to sudoers"
if [[ $(grep -c 'stack ALL=(ALL) NOPASSWD: ALL' /etc/sudoers)  -eq 0 ]]; then
	echo "stack ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
fi

echo "Step 3: Installing OpenVSwitch"
if [ ! -f /etc/init.d/openvswitch-switch ]; then
	apt-get -y install openvswitch-switch openvswitch-common openvswitch-controller
fi

echo "Step 4: Downloading and extracting OpenVSwitch 2.3.3"
pushd /root/
wget http://openvswitch.org/releases/openvswitch-2.3.3.tar.gz
tar zxvf openvswitch-2.3.3.tar.gz
rm -rf openvswitch-2.3.3.tar.gz

echo "Step 5: Installing OpenVSwitch 2.3.3"
cd openvswitch-2.3.3/
./configure --prefix=/usr --with-linux=/lib/modules/`uname -r`/build
make && make install && make modules_install
rmmod openvswitch && depmod -a

echo "Step 6: Runnung OpenVSwitch 2.3.3"
popd
/etc/init.d/openvswitch-controller stop
update-rc.d openvswitch-controller disable
/etc/init.d/openvswitch-switch restart

ovs-vsctl show
