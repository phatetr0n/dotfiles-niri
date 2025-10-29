#!/bin/bash

cat <<"EOF"
__   _______     ____  _     ____
\ \ / /_   _|   |  _ \| |   |  _ \
 \ V /  | |_____| | | | |   | |_) |
  | |   | |_____| |_| | |___|  __/
  |_|   |_|     |____/|_____|_|


EOF

# you'll need to provide cookies; make a profile and log in to youtube then point yt-dlp to it (firefox is in ~/.mozilla subfolders)
# changeable variables here for ease of access
browser="firefox"
profile="jy0ia58h.yt-dlp"

# ask user for video/playlist url and quality
read -p "Enter video or playlist URL: " url
read -p "Enter desired quality (720, 1080, etc): " quality
read -p "Enter full path to output directory (/home/user/output): " outdir
read -p "Extract MP3? (y/N): " ynmp3

# create output directory if none exists or set to current directory if blank
if [ -z "$outdir" ]; then
    outdir="."
else
    mkdir -p -- "$outdir"
fi

# quality selection block; prefer h.264 mp4 at rq height
mqs="b[height<=${quality}]/b"
sortq="res:${quality},codec:h264,ext:mp4"

# options for yt-dlp
cargs=(
  -f "$mqs"
  -S "$sortq"
  --merge-output-format mp4
  --no-post-overwrites
  --cookies-from-browser "$browser:$profile"
  -o "%(title)s.%(ext)s"
  -P "$outdir"
)

# yt-dlp download with options passed through
echo "Downloading $url at ${quality}p..."
if [[ "$ynmp3" =~ ^[Yy]$ ]]; then
    yt-dlp \
        "${cargs[@]}" \
        --extract-audio --audio-format mp3 --audio-quality 0 \
        --keep-video \
        "$url"
else
    echo "Skipping MP3 extraction..."
    yt-dlp "${cargs[@]}" \
        "$url"
fi

# remove interim mp4 files when complete if they exist
echo "Cleaning up temp files in $outdir..."
rm -f -- "$outdir"/*.f*.mp4

echo "Done!"
