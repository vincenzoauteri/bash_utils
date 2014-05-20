#!/bin/bash

# Flushing all rules
iptables -F
iptables -X

# Setting default filter policy
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT 
iptables -P FORWARD ACCEPT 

# Allow unlimited traffic on loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#INBOUND CONNECTIONS 

#allow SSH  on port 22, (established connections auto accepted)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

#allow port 1194 tcp used by vpn 
iptables -A INPUT -p tcp --dport 1194 -j ACCEPT


#NAT rules
#VPN reorute remote ->local
iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j SNAT --to-source 192.168.111.130

#drop anything that doesnt match the rules above
iptables -A INPUT -j DROP
iptables -A OUTPUT -j ACCEPT 
