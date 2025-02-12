#!/bin/bash

hyprland="/home/$(whoami)/knakto/Nix/home-manager/conf/hyprland"
img="$hyprland/background/random_wallpaper"

swww img "$img" \
	--transition-fps 60 \
	--transition-duration 2 \
	--transition-type random \
	--transition-pos top-right \
	--transition-bezier .3,0,0,.99 \
	--transition-angle 135 || true
