#!/bin/bash
swayidle -w \
    timeout 600 'hyprlock' \
    timeout 630 'niri msg action power-off-monitors' \
    resume 'niri msg action power-on-monitors' \
    before-sleep '~/dotfiles/scripts/lock.sh'
