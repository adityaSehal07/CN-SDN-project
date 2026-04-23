from mininet.topo import Topo

class BroadcastTopo(Topo):
    def build(self):
        # Add a single switch 
        s1 = self.addSwitch('s1')
        
        # Add hosts to demonstrate broadcast flooding [cite: 47]
        h1 = self.addHost('h1')
        h2 = self.addHost('h2')
        h3 = self.addHost('h3')
        
        # Link hosts to the switch
        self.addLink(h1, s1)
        self.addLink(h2, s1)
        self.addLink(h3, s1)

topos = {'broadcasttopo': BroadcastTopo}
