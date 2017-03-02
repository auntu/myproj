#!/usr/bin/env python

from mininet.net import Mininet
from mininet.node import Controller, RemoteController, Node
from mininet.cli import CLI
from mininet.log import setLogLevel, info
from mininet.link import Link, Intf

def twoswitch():

    CONTROLLER_IP='127.0.0.1'

    net = Mininet( topo=None, build=False)

    net.addController( 'c0', controller=RemoteController, ip=CONTROLLER_IP, port=6633)

    s1 = net.addSwitch( 's1' )
    s2 = net.addSwitch( 's2' )

    h1A = net.addHost( 'h1A', ip='192.168.1.5', mac='00:00:00:00:01:05' )
    h1B = net.addHost( 'h1B', ip='192.168.1.6', mac='00:00:00:00:01:06' )
    h2A = net.addHost( 'h2A', ip='192.168.1.7', mac='00:00:00:00:01:07' )
    h2B = net.addHost( 'h2B', ip='192.168.1.8', mac='00:00:00:00:01:08' )
    
    net.addLink( s1, s2 )
    net.addLink( s1, h1A )
    net.addLink( s1, h1B )
    net.addLink( s2, h2A )
    net.addLink( s2, h2B )

    # Delete old tunnel if still exists
    s1.cmd('ip link del cntl-s1 || ip link del s1-cntl')
    #s2.cmd('ip link del cntl-s2 || ip link del s2-cntl')

    # Create Veth Pair
    s1.cmd('ip link add cntl-s1 type veth peer name s1-cntl')
    s1.cmd('ip link set cntl-s1 up && ip link set s1-cntl up')

    Intf( 's1-cntl',  node=s1 )
    Intf( 'eth2', node=s2 )

    net.start()
    CLI( net )
    net.stop()

if __name__ == '__main__':
    setLogLevel( 'info' )
    twoswitch()

    
