#!/bin/bash

WALLPAPER=$HOME/knakto/Nix/assets/background/random_wallpaper
			source $HOME/knakto/Nix/assets/script/random_image_wallpaper.sh
			hyprctl hyprpaper wallpaper ",$WALLPAPER"
			echo WALLPAPER
# if [ $# == 1 ]; then
# 	if [ "$1" == "random" ]; then
# 		exit 0
# 	elif [ "$1" == up ]; then
# 		hyprctl hyprpaper wallpaper ",$WALLPAPER"
# 		exit 0
# 	else
# 		hyprctl hyprpaper preload "$1"
# 		hyprctl hyprpaper wallpaper ",$1"
# 		exit 0
# 	fi
# else
# 	hyprctl hyprpaper preload "$1"
# 	hyprctl hyprpaper wallpaper ",$1"
# 	exit 1
# fi

