#!/bin/bash

wall=$(find ~/Pictures | shuf -n1)
feh --bg-fill $wall
notify-send "Wallpaper changed" $wall -t 5
