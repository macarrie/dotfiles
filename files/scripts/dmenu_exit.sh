#!/bin/bash
#
# Show session menu

#DMENU="dmenu -i -nb $1 -nf #eeeeee -sb $1 -sf $2"
DMENU="rofi -i -dmenu -theme rofi.rasi"

choice=$(echo -e "Logout\nHibernate\nReboot\nPoweroff" | $DMENU)

case "$choice" in
    Logout) i3-msg exit & ;;
    Reboot) doas reboot & ;;
    Poweroff) doas poweroff -i & ;;
esac
