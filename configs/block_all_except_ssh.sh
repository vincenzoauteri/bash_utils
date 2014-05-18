#!/bin/bash

# Flushing all rules
iptables -F
iptables -X

# Setting default filter policy
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Allow unlimited traffic on loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

#allow SSH  on port 22, (established connections auto accepted)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT

#allow DNS 
iptables -A OUTPUT -p tcp --dport 53  -j ACCEPT
iptables -A OUTPUT -p udp --dport 53  -j ACCEPT

#allow traffic going to specific outbound ports
#iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
#iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT
#...

#drop anything that doesnt match the rules above
iptables -A INPUT -j DROP
iptables -A OUTPUT -j DROP
