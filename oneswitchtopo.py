#!/usr/bin/env python

from mininet.net import Mininet
from mininet.node import Controller, RemoteController, Node
from mininet.cli import CLI
from mininet.log import setLogLevel, info
from mininet.link import Link, Intf

def oneswitch():

    CONTROLLER_IP='127.0.0.1'

    net = Mininet( topo=None, build=False)

    net.addController( 'c0', controller=RemoteController, ip=CONTROLLER_IP, port=6633)

    s0 = net.addSwitch( 's0' )

    h0 = net.addHost( 'h0', ip='192.168.1.5', mac='00:00:00:00:01:05' )
  
    net.addLink( h0, s0 )

    # Delete old tunnel if still exists
    s0.cmd('ip link del cntl-s0 || ip link del s0-cntl')

    # Create Veth Pair
    s0.cmd('ip link add cntl-s0 type veth peer name s0-cntl')
    s0.cmd('ip link set cntl-s0 up && ip link set s0-cntl up')

    Intf( 's0-cntl',  node=s0 )
    Intf( 'eth2', node=s0 )

    net.start()
    CLI( net )
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    oneswitch()

    
