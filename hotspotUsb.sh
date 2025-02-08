#!/bin/bash

echo " Changing Wifi state to AP . . . "
sudo nmcli dev set wlp2s0 managed no

echo "Adding IP and IP forwarding . . . " 
sudo sysctl -w net.ipv4.ip_forward=1

sudo ip addr add 192.168.100.1/24 dev wlp2s0
sudo iptables -t nat -A POSTROUTING -o enp0s20f0u3 -j MASQUERADE
sudo iptables -A FORWARD -i wlp2s0 -o enp0s20f0u3 -j ACCEPT
sudo iptables -A FORWARD -i enp0s20f0u3 -o wlp2s0 -m state --state RELATED,ESTABLISHED -j ACCEPT

echo "Starting dnsmasq and opening Hotspot.. "
sudo systemctl start dnsmasq
sudo systemctl start hostapd
