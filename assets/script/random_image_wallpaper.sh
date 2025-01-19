#!/bin/bash

# Directory containing wallpaper images
WALLPAPER_DIR="$HOME/knakto/Nix/assets/background"

IMAGE_FILES=($(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \)))

if [ ${#IMAGE_FILES[@]} -eq 0 ]; then
    echo "No images found in $WALLPAPER_DIR"
    exit 1
fi

RANDOM_IMAGE="${IMAGE_FILES[RANDOM % ${#IMAGE_FILES[@]}]}"

rm -rf "$WALLPAPER_DIR/random_wallpaper"
cp "$RANDOM_IMAGE" "$WALLPAPER_DIR/random_wallpaper"
