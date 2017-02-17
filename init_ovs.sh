#!/bin/bash

if [[ $(whoami)  != 'root' ]]; then
	echo "Run as root";
	exit;
fi

apt-get update -y && apt-get upgrade -y

if [[ $(grep -c 'stack ALL=(ALL) NOPASSWD: ALL' /etc/sudoers)  -eq 0 ]]; then
	echo "stack ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
fi

apt-get -y install openvswitch-switch openvswitch-common openvswitch-controller

pushd /root/
wget http://openvswitch.org/releases/openvswitch-2.3.3.tar.gz
tar zxvf openvswitch-2.3.3.tar.gz
rm -rf openvswitch-2.3.3.tar.gz

cd openvswitch-2.3.3/
./configure --prefix=/usr --with-linux=/lib/modules/`uname -r`/build
make && make install && make modules_install
rmmod openvswitch && depmod -a

popd
/etc/init.d/openvswitch-controller stop
update-rc.d openvswitch-controller disable
/etc/init.d/openvswitch-switch restart

ovs-vsctl show
