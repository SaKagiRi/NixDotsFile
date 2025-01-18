{
	config,
	inputs,
	pkgs,
	lib,
	...
}:
let
  w1 = "/home/knakto/knakto/Nix/assets/background/1130518.png";
  w2 = "/home/knakto/knakto/Nix/assets/background/1138016.png";
  w3 = "/home/knakto/knakto/Nix/assets/background/1225634.jpg";
  w4 = "/home/knakto/knakto/Nix/assets/background/1292004.jpg";
  w5 = "/home/knakto/knakto/Nix/assets/background/1295677.png";
  w6 = "/home/knakto/knakto/Nix/assets/background/1355397.jpeg";
  w7 = "/home/knakto/knakto/Nix/assets/background/1356447.png";
  w8 = "/home/knakto/knakto/Nix/assets/background/1386768.png";
  w9 = "/home/knakto/knakto/Nix/assets/background/1386770.png";
  w0 = "/home/knakto/knakto/Nix/assets/background/1386771.png";
in 
{

	wayland.windowManager.hyprland = {
		enable = true;
		settings = {
			"$mod" = "SUPER";
			input = {
				kb_layout="us,th";
				kb_options="grp:win_space_toggle";
			};
			# debug = { disable_logs = false; };
			xwayland = {
				force_zero_scaling = true;
				use_nearest_neighbor = true;
			};
			general = {
				gaps_in = 14;
				gaps_out = 12;
				border_size = 3;
				layout = "dwindle";
				resize_on_border = true;
			};
			dwindle = {
				preserve_split = true;
			};
			decoration = {
				rounding = 8;
				blur = {
					enabled = true;
					size = 2;
					passes = 4;
					new_optimizations = true;
				};
				# drop_shadow = "yes";
				# shadow_range = 20;
				# shadow_render_power = 4;
			};
			animations = {
				bezier = [
					"smooth, 0.14, 0.03, 0.09, 1"
					"ease, 0.25, 0.1, 0.25, 1"
					"ease-win, 0.27, 0.27, 0, 1.01"
				];
				animation = [
					# "windows, 1, 7, default"
					"windows, 1, 3.5, ease-win"
					"windowsOut, 1, 6, default, popin 100%"
					"border, 1, 7, smooth"
					"borderangle, 1, 8, default"
					# "fade, 1, 7, default"
					"workspaces, 1, 2.5, ease"
				];
			};
			misc = {
				disable_hyprland_logo = true;
			};
			exec-once = [
				"hyprlock || hyprctl dispatch exit"
				#"waybar"
				"hyprpaper"
				"wl-paste --watch cliphist store"
				"fcitx5"
			];
			env = [
				"GDK_BACKEND,wayland,x11,remmina"
				"SDL_VIDEODRIVER,wayland"
				"CLUTTER_BACKEND,wayland"
				"XDG_SESSION_TYPE,wayland"
				# "NIXOS_OZONE_WL,1"

				"MOZ_ENABLE_WAYLAND,1"
				"MOZ_DBUS_REMOTE,1"

				"XMODIFIERS,@im=fcitx"
				"QT_IM_MODULE,fcitx"

				#"WLR_NO_HARDWARE_CURSORS,1"
				"WLR_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0"

				"SHELL,/home/knakto/.nix-profile/bin/zsh"
			];
			monitor = [
				", highres, auto, auto"
				"eDP-1 , highres:120, auto, 1.25"
			];
			bind = [
				# Terminal
				"CTRL ALT, T, exec, kitty"
				# Exit (temporary)
				"$mod, ESCAPE, exec, pidof wleave || wleave -p layer-shell"
				# Lockscreen
				"CTRL ALT, L, exec, hyprlock"
				"ALT, ESCAPE, exec, poweroff"
				# Application
				"$mod, E, exec, xdg-open ~"
				# Clipboard
				"$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
				# Screenshot
				"$mod, Print, exec, hyprshot -m region"
				#Rofi
				"$mod, B, exec, kill $(ps -la | grep waybar | awk '{print $4}') || waybar"
				#Gamemode
				"$mod SHIFT, G, exec, /home/knakto/knakto/Nix/assets/script/gamemode.sh"
				#Wallpapers
				"CTRL, 1, exec, hyprctl hyprpaper wallpaper ,${w1}"
				"CTRL, 2, exec, hyprctl hyprpaper wallpaper ,${w2}"
				"CTRL, 3, exec, hyprctl hyprpaper wallpaper ,${w3}"
				"CTRL, 4, exec, hyprctl hyprpaper wallpaper ,${w4}"
				"CTRL, 5, exec, hyprctl hyprpaper wallpaper ,${w5}"
				"CTRL, 6, exec, hyprctl hyprpaper wallpaper ,${w6}"
				"CTRL, 7, exec, hyprctl hyprpaper wallpaper ,${w7}"
				"CTRL, 8, exec, hyprctl hyprpaper wallpaper ,${w8}"
				"CTRL, 9, exec, hyprctl hyprpaper wallpaper ,${w9}"
				"CTRL, 0, exec, hyprctl hyprpaper wallpaper ,${w0}"
				# Window
				"$mod, Q, killactive"
				"$mod, M, fullscreen, 1"
				"$mod, R, togglesplit,"
				"$mod, P, pseudo,"
				"$mod SHIFT, P, pin"
				"$mod SHIFT, M, fullscreen, 0"
				"$mod, F, togglefloating"
				"$mod, G, togglegroup"
				"CTRL ALT, G, lockgroups, toggle"
				"CTRL ALT, right, changegroupactive, f"
				"CTRL ALT, left, changegroupactive, b"
				"$mod, return, exec, rofi -show drun"
				# Move to workspace
				"$mod , A, workspace, r-1"
				"$mod , D, workspace, r+1"
				"$mod SHIFT, A, movetoworkspace, r-1"
				"$mod SHIFT, D, movetoworkspace, r+1"
				# Move window to workspace
				"$mod, 1, workspace, 1"
				"$mod, 2, workspace, 2"
				"$mod, 3, workspace, 3"
				"$mod, 4, workspace, 4"
				"$mod, 5, workspace, 5"
				"$mod, 6, workspace, 6"
				"$mod, 7, workspace, 7"
				"$mod, 8, workspace, 8"
				"$mod, 9, workspace, 9"
				"$mod, 0, workspace, 10"
				"$mod SHIFT, 1, movetoworkspace, 1"
				"$mod SHIFT, 2, movetoworkspace, 2"
				"$mod SHIFT, 3, movetoworkspace, 3"
				"$mod SHIFT, 4, movetoworkspace, 4"
				"$mod SHIFT, 5, movetoworkspace, 5"
				"$mod SHIFT, 6, movetoworkspace, 6"
				"$mod SHIFT, 7, movetoworkspace, 7"
				"$mod SHIFT, 8, movetoworkspace, 8"
				"$mod SHIFT, 9, movetoworkspace, 9"
				"$mod SHIFT, 0, movetoworkspace, 10"
				
				"$mod, left, movefocus, l"
				"$mod, left, bringactivetotop,"
				"$mod, right, movefocus, r"
				"$mod, right, bringactivetotop,"
				"$mod, up, movefocus, u"
				"$mod, up, bringactivetotop,"
				"$mod, down, movefocus, d"
				
				"$mod, H, movefocus, l"
				"$mod, H, bringactivetotop,"
				"$mod, L, movefocus, r"
				"$mod, L, bringactivetotop,"
				"$mod, K, movefocus, u"
				"$mod, K, bringactivetotop,"
				"$mod, J, movefocus, d"
				"$mod, J, bringactivetotop,"

				# submaps
				"ALT CTRL, ESCAPE, submap, passthrough"
				"ALT, M, submap, movewindow"
				"ALT, R, submap, resizewindow"
			];
			windowrule = [
				"animation slide, notifications"
			];
			windowrulev2 = [
				"stayfocused, class:hyprland-share-picker"
				"dimaround, class:hyprland-share-picker"
			];
			bindel = [
				", XF86AudioRaiseVolume, exec, ~/.config/hypr/scripts/volume.sh raise"
				", XF86AudioLowerVolume, exec, ~/.config/hypr/scripts/volume.sh lower"
				", XF86MonBrightnessUp, exec, brightnessctl -d intel_backlight set +2%"
				", XF86MonBrightnessDown, exec, brightnessctl -d intel_backlight set 2%-"
			];
			bindl = [
				", XF86AudioMute, exec, ~/.config/hypr/scripts/volume.sh mute"
			];
			bindm = [
				"$mod, mouse:272, movewindow"
				"$mod, mouse:273, resizewindow"
			];
			gestures = {
				# See https://wiki.hyprland.org/Configuring/Variables/ for more
				workspace_swipe = "on";
				workspace_swipe_distance = "200";
				workspace_swipe_cancel_ratio = "0.35";
				workspace_swipe_use_r = "true";
			};
		};
		extraConfig = ''
			submap = passthrough
				bind = ALT CTRL,escape,exec,notify-send -e -u low -a Hyprland "Normal mode"
				bind = ALT CTRL,escape,submap,reset
			submap = movewindow
				binde = , right, movewindow, r
				binde = , left, movewindow, l
				binde = , up, movewindow, u
				binde = , down, movewindow, d
				binde = , l, movewindow, r
				binde = , h, movewindow, l
				binde = , k, movewindow, u
				binde = , j, movewindow, d
				bind = ,escape,exec,notify-send -e -u low -a Hyprland "Normal mode"
				bind= ,catchall,submap,reset
				bind = ,escape,submap,reset
			submap = resizewindow
				binde = , right, resizeactive, 20 0
				binde = , left, resizeactive, -20 0
				binde = , up, resizeactive, 0 -20
				binde = , down, resizeactive, 0 20
				binde = , l, resizeactive, 20 0
				binde = , h, resizeactive, -20 0
				binde = , k, resizeactive, 0 -20
				binde = , j, resizeactive, 0 20
				bind = ,escape,exec,notify-send -e -u low -a Hyprland "Normal mode"
				bind= ,catchall,submap,reset
				bind = ,escape,submap,reset
			### Reset ###
			submap = reset
		'';
		# plugins = with pkgs.hyprland-plugins; [
		# 	hyprwinwrap
		# ];
	};

	programs.hyprlock = {
		enable = true;
		settings = {
			general = {
				disable_loading_bar = true;
				grace = 3;
				hide_cursor = true;
				no_fade_in = false;
			};

			background = lib.mkForce [
				{
					path = "screenshot";
					blur_passes = 3;
					blur_size = 8;
				}
			];

			image = {
				path = "~/.face";
				# monitor = "eDP-1";
				size = "250";
				position = "0, 100";
				rounding = -1;
				border_size = 4;
				border_color = "rgb(221, 221, 221)";
				halign = "center";
				valign = "center";
			};

			input-field = lib.mkForce [
				{
					size = "200, 50";
					position = "0, -100";
					# monitor = "eDP-1";
					dots_center = true;
					fade_on_empty = false;
					font_color = "rgb(202, 211, 245)";
					inner_color = "rgb(91, 96, 120)";
					outer_color = "rgb(24, 25, 38)";
					outline_thickness = 5;
					placeholder_text = ''<span foreground="##cad3f5">Password...</span>'';
					shadow_passes = 2;
				}
			];
		};
	};

	programs.rofi = {
		enable = true;
		location = "center";
		theme = "material";
		plugins = [
				pkgs.rofi-calc
				pkgs.rofi-emoji
				pkgs.rofi-systemd
		];
		};

	programs.waybar = {
		enable = true;
		style = ../../assets/waybar/style.css;
		settings = [{
			height = 30;
			layer = "top";
			position = "top";
			modules-center = [ "hyprland/workspaces" ];
			modules-left = [ "group/hardware" "tray" ];
			modules-right = [
				#"custom/update"
				"pulseaudio"
				"network"
				"bluetooth"
				"temperature"
				"clock"
				];
			"group/hardware" = {
				orientation = "horizontal";
				modules = [ "cpu" "memory" ];
			};
			"custom/update" = {
				format = "(-) { }";
				tooltrip-format = "{ }";
				ascape = true;
				return-type = "json";
				exec = "kitty";
				on-click = "kitty";
				tooltrip = false;
			};
			network = {
				format = "ᯤ {}";
				format-disconnected = "Disconnected ⚠︎";
			};
			bluetooth = {
					format = "ᛒ {}";
					tooltip = true;
					tooltip-format = "- {controller_alias}\t{controller_address}\n- {device_alias}\t{device_address}";
				format-disabled = "ᛒ";
				format-connected = "ᛒ";
			};
			pulseaudio = {
				format = "{icon} {volume}%";
				format-bluetooth = "ᛒ {volume}%";
				format-bluetooth-muted = "ᛒ 0%";
				format-icons = {
					default = [ "၊၊||၊" ];
					handsfree = "📱";
					headphones = "🎧";
					headset = "";
					phone = "📞";
					portable = "📞";
				};
			};
			clock = {
				format-alt = "{:%Y-%m-%d}";
				tooltip-format = "{:%Y-%m-%d | %H:%M}";
			};
			memory = {
				format = "RAM: {}%";
			};
			cpu = {
				format = "CPU: {usage}%";
				tooltip = false;
			};
			temperature = {
				format = "🌡 {}";
			};
		}];
	};

	 services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
				"${w1}"
				"${w2}"
				"${w3}"
				"${w4}"
				"${w5}"
				"${w6}"
				"${w7}"
				"${w8}"
				"${w9}"
				"${w0}"
      ];
      wallpaper = [
				",${w1}"
				",${w2}"
				",${w3}"
				",${w4}"
				",${w5}"
				",${w6}"
				",${w7}"
				",${w8}"
				",${w9}"
				",${w0}"
			];
    };
  };

	 services.mako = {
    enable = true;
    backgroundColor = "#282a36af";
    textColor = "#f4f7fa";
    borderColor = "#282a36";
    progressColor = "#00ffff3a";
    borderRadius = 5;
    margin = "5, 20";
    width = 375;
    height = 175;
    layer = "overlay";
    extraConfig = ''
[urgency=low]
border-color=#879a9c
default-timeout=7000

[urgency=normal]
border-color=#b0cfd1
default-timeout=10000

[urgency=high]
border-color=#d1a8f0'';
  };
}
