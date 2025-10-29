#!/bin/bash

cat <<"EOF"
__   _______     ____  _     ____
\ \ / /_   _|   |  _ \| |   |  _ \
 \ V /  | |_____| | | | |   | |_) |
  | |   | |_____| |_| | |___|  __/
  |_|   |_|     |____/|_____|_|


EOF

# ask user for video/playlist url and quality
read -p "Enter video or playlist URL: " url
read -p "Enter desired quality (720, 1080, etc): " quality

# yt-dlp download with options passed through
yt-dlp -f "bestvideo[height<="$quality"]+bestaudio/best" --merge-output-format mp4 --extract-audio --audio-format mp3 --audio-quality 0 --keep-video "$url"

# remove interim mp4 files when complete
rm -f *.f*.mp4
