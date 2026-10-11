#!/usr/bin/env bash
set -euo pipefail

wallpaper="${1:?Usage: theme.sh /path/to/wallpaper}"

if [[ ! -f "$wallpaper" ]]; then
  printf 'Image not found: %s\n' "$wallpaper" >&2
  exit 1
fi

# matugen --config "$HOME/.config/matugen/config.toml" \
#   image "$wallpaper" --mode dark --source-color-index 0 \
#   --type scheme-smart
#   --type scheme-vibrant
#   --type scheme-neutral

matugen --config "$HOME/.config/matugen/config.toml" \
  image "$wallpaper" --mode smart --prefer saturation \
  --type scheme-smart
# --type scheme-vibrant
# --type scheme-neutral

# hyprctl reload
# pkill -USR1 -u "$(id -u)" -x kitty || true
# swaync-client --reload-css --skip-wait
# pkill -USR2 -u "$(id -u)" -x btop || true

# Start reloads together, after Matugen finishes generating.
(hyprctl reload) &
(pkill -USR1 -u "$(id -u)" -x kitty || true) &
(swaync-client --reload-css --skip-wait) &
(pkill -USR2 -u "$(id -u)" -x btop || true) &

wait
