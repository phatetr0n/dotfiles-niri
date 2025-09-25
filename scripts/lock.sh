#!/bin/bash

# if idle for 15s power down output
swayidle -w \
    timeout 15 'niri msg action power-off-monitors' \
    resume 'niri msg action power-on-monitors' &

# lock screen
swaylock -i /var/tmp/wp_blur.png

# kill newest swayidle so it doesn't keep carrying on
pkill --newest swayidle
