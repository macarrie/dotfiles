#!/bin/bash

STATUS="Down"
IFACE=`ip tuntap | sed 's/\(\w\):.*/\1/'`

if [ ! -z $IFACE ]
then
    NETWORK_ADDR=`ip addr show dev $IFACE | sed -n 's/.*inet \(.*\)\/...*/\1/p'`

    ping -c 1 $NETWORK_ADDR > /dev/null

    if [ $? -eq 0 ]
    then
        STATUS="Up"
    fi
fi

color="#FF4300"
if [ $STATUS == "Up" ]
then
    color="#00E676"
fi

echo "VPN <i>$STATUS</i>"
echo "VPN <i>$STATUS</i>"
echo $color
