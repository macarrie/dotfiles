#!/bin/bash

amixer -D pulse sset Master '5%-'
notify-send "Volume" `amixer get Master | awk -F"[][]" '/dB/ {print $2}'` -t 500
