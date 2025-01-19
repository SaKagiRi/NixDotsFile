#!/bin/bash

source $HOME/knakto/Nix/assets/script/random_image_wallpaper.sh

WALLPAPER="$HOME/knakto/Nix/assets/background/random_wallpaper"

hyprctl hyprpaper unload $WALLPAPER && hyprctl hyprpaper preload $WALLPAPER && hyprctl hyprpaper wallpaper ",$WALLPAPER"

echo WALLPAPER
