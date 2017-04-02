#!/bin/bash

locker='~/scripts/i3lock-pixel.sh'

#/usr/bin/VBoxClient-all

# Set keymap
setxkbmap fr

# Export localtime
export TZ=/etc/localtime

# Merge Xresources
xrdb ~/.Xresources

# Startup apps

# Notifications server
dunst &
# Hide mouse when inactive
unclutter &
# Network manager applet
nm-applet &
# Set desktop background color
xsetroot -solid "#2F343F" &
# Start autolock
xautolock -locker $locker -time 10 -notify 30 -notifier "notify-send 'Autolock in 30s' 'Réveille toi, tocard' -u critical -t 15000" &
# Maps caps lock to additional escape
setxkbmap -option caps:escape &
# Numlock at startup
numlockx &
# Disable touchpad when typing
syndaemon -i 0.5 -d &
# Click when tapping touchpad
synclient tapbutton1=1 &
# Disable effing hardware bell
xset b off
# Compositor
compton &
# Screen dim
redshift-gtk &
# External USB drives automount
udiskie -s &
# Dropbox daemon
#dropbox start &

# Load tmux sessions
tmuxp load -d ~/.tmuxp/*.tmuxp.yaml

# Start WM
exec i3
