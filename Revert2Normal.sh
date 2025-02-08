#!/bin/bash

echo "Reverting to normal WIFI mode"
echo "Disabling hotspot and dnsmasq . . ."
sudo systemctl stop hostapd
sudo systemctl stop dnsmasq

echo "Reverting IP forwarding to default . . ."
sudo sysctl -w net.ipv4.ip_forward=0

echo "Deleting assigned IP address to wifi . . ."
sudo ip addr del 192.168.100.1/24 dev wlp2s0

echo "Changing Wifi to managed state . . . "
sudo nmcli dev set wlp2s0 managed yes

echo "Finishing up... "
sudo systemctl restart NetworkManager

echo "Done. You might get disconnected and need to auto-connect"






