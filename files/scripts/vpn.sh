#!/usr/bin/env bash

STATUS="Down"
IFACE=`ip tuntap | sed 's/\(\w\):.*/\1/'`

if [ ! -z $IFACE  ]; then
    NETWORK_ADDR=`ip addr show dev $IFACE | sed -n 's/.*inet \(.*\)\/...*/\1/p'`

    ping -c 1 $NETWORK_ADDR > /dev/null

    if [ $? -eq 0  ]; then
        STATUS="Up"
    fi
fi

echo "VPN $STATUS"
