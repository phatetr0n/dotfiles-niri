#!/bin/bash
swayidle -w \
    timeout 600 'swaylock -f -i wp_blur.png' \
    timeout 630 'niri msg action power-off-monitors' \
    resume 'niri msg action power-on-monitors' \
    before-sleep '~/dotfiles/scripts/lock.sh'
