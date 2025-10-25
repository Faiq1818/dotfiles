#!/usr/bin/env sh
OUT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$OUT_DIR"
FILE="$OUT_DIR/screenshot-$(date +%Y%m%d-%H:%M:%S).png"

# slurp mengembalikan geometry; grim menerima geometry lewat -g
GEOM=$(slurp) || exit 1
grim -g "$GEOM" "$FILE" || exit 1

# copy ke clipboard jika tersedia
if command -v wl-copy >/dev/null 2>&1; then
  wl-copy --type image/png < "$FILE"
fi
