#!/usr/bin/env bash
set -e

# Load pywal colors
. ~/.cache/wal/colors.sh
for i in {0..15}; do
    eval "export COLOR$i=\"\${color$i}\""
done

CFG=~/.config/niri/config.kdl
THEME_TEMPLATE=~/.config/niri/theme.kdl.in

# Remove old theme block
tmpfile=$(mktemp)
awk '/^\/\/ BEGIN_THEME/{flag=1; next} /^\/\/ END_THEME/{flag=0; next} !flag' "$CFG" > "$tmpfile"

# Generate fresh theme from template
theme=$(envsubst < "$THEME_TEMPLATE")

# Prepend theme + rest of config
printf "%s\n%s\n" "$theme" "$(cat "$tmpfile")" > "$CFG"
rm "$tmpfile"
