#!/usr/bin/env bash
# if idle for 15s after lock generate a temp counter
swayidle -w \
    timeout 15 'niri msg action power-off-monitors' \
    resume 'niri msg action power-on-monitors' &
tempidle_pid=$!

# lock the screen
hyprlock

# after unlock kill temp counter
kill "$tempidle_pid"
