#!/bin/bash
# 15 minute swayidle then activate lock script
swayidle -w \
    timeout 900 '$HOME/dotfiles/scripts/lock.sh'
