#!/usr/bin/env bash

wall=$(find ~/Pictures | shuf -n1)
echo "$wall" > ~/.wallpaper
feh --bg-fill $wall
notify-send "Wallpaper changed" $wall -t 5
