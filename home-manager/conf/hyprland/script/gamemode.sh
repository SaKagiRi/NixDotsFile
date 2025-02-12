#!/bin/bash

HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')
if [ "$HYPRGAMEMODE" = 1 ] ; then
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
		keyword decoration:blur:passes 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 1;\
        keyword decoration:rounding 0"
	
	hyprctl keyword "windowrule opacity 1 override 1 override 1 override, ^(.*)$"
	kill $(ps -la | grep waybar | awk '{print $4}')
	swww kill
    exit
else
	hyprctl reload
	swww init
	swww img "$HOME/knakto/Nix/home-manager/conf/hyprland/background/random_wallpaper" \
	--transition-fps 60 \
	--transition-duration 2 \
	--transition-type random \
	--transition-pos top-right \
	--transition-bezier .3,0,0,.99 \
	--transition-angle 135 || true
    exit
fi
