#!/bin/bash

echo "🚀 Starting CN-SDN Project..."

PROJECT_DIR="/home/sehal_07/Desktop/CN-SDN-project"
POX_DIR="$PROJECT_DIR/pox"

# Kill process using port 6633
echo "🔪 Killing process on port 6633..."
sudo fuser -k 6633/tcp

# Clean Mininet
echo "🧹 Cleaning Mininet..."
sudo mn -c

# Start POX controller in new terminal
echo "🧠 Starting POX controller..."
gnome-terminal -- bash -c "cd $POX_DIR; python3 pox.py log.level --DEBUG broadcast_controller; exec bash"

# Wait for controller
sleep 5

# Start Mininet topology in new terminal
echo "🌐 Starting Mininet topology..."
gnome-terminal -- bash -c "sudo python3 $PROJECT_DIR/broadcast_topo.py; exec bash"

# Wait for Mininet
sleep 5

# Create Mininet CLI commands
echo "📡 Running Mininet tests..."

cat <<EOF > /tmp/mn_commands.txt
pingall
h1 ping h2 -c 4
h1 ping -b 10.0.0.255 -c 20
h3 iperf -s &
h4 iperf -c 10.0.0.3 -t 10
exit
EOF

# Run commands
sudo mn --custom $PROJECT_DIR/broadcast_topo.py --topo mytopo --controller remote --switch ovsk < /tmp/mn_commands.txt

# Dump flows
echo "📊 Dumping OVS flows..."
sudo ovs-ofctl dump-flows s1

# Launch Wireshark
echo "🦈 Launching Wireshark..."
sudo wireshark &

echo "✅ Done!"
