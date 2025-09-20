#!/bin/bash
# use magick to blur the bg based on bg set using waypaper; aside from first run there should always be one in temp

magick /var/tmp/wp.png -blur 0x12 /var/tmp/wp_blur.png
