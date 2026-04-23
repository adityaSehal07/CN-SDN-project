"""
Custom Mininet topology for Broadcast Traffic Control project.
Star topology: 1 switch, 4 hosts.
"""

from mininet.topo import Topo
from mininet.net import Mininet
from mininet.node import RemoteController
from mininet.cli import CLI
from mininet.log import setLogLevel

class StarTopo(Topo):
    def build(self):
        s1 = self.addSwitch('s1')
        for i in range(1, 5):
            h = self.addHost(f'h{i}', ip=f'10.0.0.{i}/24')
            self.addLink(h, s1)

def run():
    topo = StarTopo()
    net  = Mininet(topo=topo,
                   controller=RemoteController('c0', ip='127.0.0.1', port=6633))
    net.start()
    print("\n=== Broadcast Traffic Control Topology ===")
    print("Hosts: h1(10.0.0.1), h2(10.0.0.2), h3(10.0.0.3), h4(10.0.0.4)")
    print("Controller: POX at 127.0.0.1:6633\n")
    CLI(net)
    net.stop()

if __name__ == '__main__':
    setLogLevel('info')
    run()
