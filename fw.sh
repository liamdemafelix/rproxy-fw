#!/bin/bash

# Reverse proxy IPv4
REVERSE_PROXY=""

# Determine the action
ACTION=$1
if [ -z $ACTION ]
then
	echo "Invalid action. Accepted: start | stop"
	exit 1
fi

# Start action
do_start () {
	# Sample Service. Change 90 to whatever port you want to block.
	/usr/sbin/iptables -A INPUT -p tcp --dport 90 -s $REVERSE_PROXY -j ACCEPT
	/usr/sbin/iptables -A INPUT -p tcp --dport 90 -j DROP
	/usr/sbin/ip6tables -A INPUT -p tcp --dport 90 -j DROP
	
	return 0
}

# Stop action
do_stop () {
	# Sample Service. Change 90 to whatever port you want to block.
	/usr/sbin/iptables -D INPUT -p tcp --dport 90 -s $REVERSE_PROXY -j ACCEPT
	/usr/sbin/iptables -D INPUT -p tcp --dport 90 -j DROP
	/usr/sbin/ip6tables -D INPUT -p tcp --dport 90 -j DROP
	
	return 0
}

# Run the action
if [ "$ACTION" = "start" ]
then
	do_start
	exit $?
elif [ "$ACTION" = "stop" ]
then
	do_stop
	exit $?
else
	echo "Invalid action. Accepted: start | stop"
	exit 1
fi
