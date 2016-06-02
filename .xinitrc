#!/bin/bash
/usr/bin/VBoxClient-all

# Set keymap
setxkbmap fr

# Merge Xresources
xrdb ~/.Xresources

# Startup apps

# Notifications server
dunst &
# Hide mouse when inactive
unclutter &
# Dropbox daemon
dropbox start &
# Network manager applet
nm-applet &
# Set desktop background color
xsetroot -solid "#2F343F" &
# Start autolock
xautolock -locker '~/scripts/i3lock-wrapper.sh --logo' -time 10 -notify 30 -notifier "notify-send 'Autolock in 30s' 'Réveille toi, tocard' -u critical -t 15000" &
# Maps caps lock to additional escape
setxkbmap -option caps:escape &
# Disable touchpad when typing
syndaemon -i 0.5 -d &
# Click when tapping touchpad
synclient tapbutton1=1 &
# Disable effing hardware bell
xset b off
# Compositor
compton &
# Start tmux
tmux new-session -s tmp -d
tmux run-shell $HOME/.tmux/plugins/tmp/bindings/install_plugins

# Start WM
exec i3
