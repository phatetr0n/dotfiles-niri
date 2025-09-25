#!/bin/bash
# use magick to blur the bg based on bg if wp is newer than wp_blur

if [[ /var/tmp/wp.png -nt /var/tmp/wp_blur.png ]]; then
    magick /var/tmp/wp.png -blur 0x12 /var/tmp/wp_blur.png
fi
