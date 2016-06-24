#!/bin/bash
#
# Show session menu

#DMENU="dmenu -i -nb $1 -nf #eeeeee -sb $1 -sf $2"
DMENU="rofi -dmenu"

choice=$(echo -e "Logout\nHibernate\nReboot\nShutdown" | $DMENU)

case "$choice" in
    Logout) i3-msg exit & ;;
    Hibernate) xautolock -locknow && systemctl hibernate -i & ;;
    Reboot) systemctl reboot & ;;
    Shutdown) systemctl poweroff -i & ;;
esac
