#!/usr/bin/env bash

wallpaper=$(< ~/.wallpaper)
lock_bg_file="/tmp/lock_bg_$(basename $wallpaper)"

dim_percentage=50
blur_radius=5

background=00000000
foreground=FFFFFFFF
letterEnteredColor=d23c3dff
letterRemovedColor=d23c3dff
passwordCorrect=00000000
passwordIncorrect=d23c3dff

screen_info=$(xrandr | grep '*' | tr -s ' ' | cut -d' ' -f 2)
screen_width=$(echo "$screen_info" | cut -d'x' -f 1)
screen_height=$(echo "$screen_info" | cut -d'x' -f 2)

lock() {
    i3lock \
            -i $lock_bg_file \
            --clock \
            --force-clock \
            --timepos="w-30:h-65" \
            --time-align=2 \
            --date-align=2 \
            --timestr="%H:%M" \
            --datestr "Type password to unlock..." \
            --date-font=Cabin \
            --timesize=100 \
            --time-font=Source-Code-Pro \
            --line-uses-inside \
            --insidecolor=$background \
            --radius=20 \
            --ring-width=4 \
            --veriftext="" \
            --wrongtext="" \
            --timecolor="$foreground" \
            --datecolor="$foreground" \
            --ringcolor=$foreground \
            --ringvercolor=$foreground \
            --ringwrongcolor=$foreground \
            --separatorcolor=$background \
            --keyhlcolor=$letterEnteredColor \
            --bshlcolor=$letterRemovedColor \
            --insidevercolor=$passwordCorrect \
            --insidewrongcolor=$passwordIncorrect \
            --indpos="w-350:h-100" \
            #--datepos="tx+24:ty+25" \
}

create_lock_background() {
    # Use cached lockscreen wallpaper if available
    if [ -f $lock_bg_file ]; then
        if [ "lock_bg_$(basename $wallpaper)" == "$(basename $lock_bg_file)" ]; then
            # Use cache, don't generate lockscreen bg
            return
        else
            rm -f /tmp/lock_bg_*
        fi
    fi

    # No cache detected, generate lockscreen background
    ## Resize wallpaper to screen size
    convert "$wallpaper" -resize "${screen_width}x${screen_height}""^" -gravity center -extent "${screen_width}x${screen_height}" "$lock_bg_file"
    ## Dim image
    convert $lock_bg_file -fill black -colorize ${dim_percentage}% $lock_bg_file
    ## Blur image
    convert $lock_bg_file -blur 0x$blur_radius $lock_bg_file
}

create_lock_background
lock
