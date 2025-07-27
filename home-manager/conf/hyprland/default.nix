{
  lib,
  inputs,
  self,
  pkgs,
  ...
}: let
  bg_path = "${self}/home-manager/conf/hyprland/background";
  w1 = "anime.jpg";
  w2 = "20rq9u5ug7ye1.jpeg";
  w3 = "nix.jpg";
  w4 = "wallpaperflare.com_wallpaper.jpg";
  w5 = "1355397.jpeg";
  w6 = "1386771.png";
  w7 = "1148520.jpg";
  w8 = "1363443.png";
  w9 = "1356447.png";
  w0 = "1148498.jpg";
  script = "${self}/home-manager/conf/hyprland/script";
in {
  imports = [
    ./waybar
    ./hyprlock
    ./luancher
  ];

  home.packages = with pkgs; [swww wlogout];

  xdg.portal.enable = true;
  xdg.portal.configPackages = [ pkgs.hyprland ];
  xdg.portal.extraPortals = with pkgs;
    [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal
      xdg-desktop-portal-gtk
    ]
    ++ [
      # inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
    ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      input = {
        kb_layout = "us,th";
        kb_options = "grp:win_space_toggle";
      };
      debug = {disable_logs = false;};
      xwayland = {
        force_zero_scaling = true;
        use_nearest_neighbor = true;
      };
      general = {
        gaps_in = 14;
        gaps_out = 9;
        border_size = 2;
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
        # "hyprlock || hyprctl dispatch exit"
        "waybar"
        "swaync" #notification
        "${pkgs.swww}/bin/swww-daemon"
        "./script/change_wallpaper.sh"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland"
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
        "$mod, ESCAPE, exec, kill $(ps -la | grep wlogout | awk '{print $4}') || wlogout"
        # Lockscreen
        "CTRL ALT, L, exec, hyprlock"
        "ALT, ESCAPE, exec, poweroff"
        # Clipboard
        "$mod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
        # Screenshot
        "$mod, Print, exec, grim"
        "$mod, Print, exec, grim | wl-copy"
        "$mod SHIFT, Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        #Rofi
        "$mod, B, exec, kill $(ps -la | grep waybar | awk '{print $4}') || waybar"
        # "$mod SHIFT, B, exec, kill $(ps -la | grep waybar | awk '{print $4}')"
        # "$mod, B, exec, waybar"
        #Gamemode
        "$mod SHIFT, G, exec, ${script}/gamemode.sh"
        #Wallpapers
        "$mod SHIFT, W, exec, source ${script}/random_wallpaper.sh"
        "$mod , W, exec, ${script}/random_wallpaper.sh && ${script}/set_wallpaper.sh"
        "CTRL, 1, exec, ${script}/random_wallpaper.sh ${w1} && ${script}/set_wallpaper.sh"
        "CTRL, 2, exec, ${script}/random_wallpaper.sh ${w2} && ${script}/set_wallpaper.sh"
        "CTRL, 3, exec, ${script}/random_wallpaper.sh ${w3} && ${script}/set_wallpaper.sh"
        "CTRL, 4, exec, ${script}/random_wallpaper.sh ${w4} && ${script}/set_wallpaper.sh"
        "CTRL, 5, exec, ${script}/random_wallpaper.sh ${w5} && ${script}/set_wallpaper.sh"
        "CTRL, 6, exec, ${script}/random_wallpaper.sh ${w6} && ${script}/set_wallpaper.sh"
        "CTRL, 7, exec, ${script}/random_wallpaper.sh ${w7} && ${script}/set_wallpaper.sh"
        "CTRL, 8, exec, ${script}/random_wallpaper.sh ${w8} && ${script}/set_wallpaper.sh"
        "CTRL, 9, exec, ${script}/random_wallpaper.sh ${w9} && ${script}/set_wallpaper.sh"
        "CTRL, 0, exec, ${script}/random_wallpaper.sh ${w0} && ${script}/set_wallpaper.sh"
        # Window
        "$mod, TAB, overview:toggle, toggle"
        "$mod, Q, killactive"
        "$mod, M, fullscreen, 1"
        "$mod, R, togglesplit,"
        "$mod, P, pseudo,"
        "$mod SHIFT, M, fullscreen, 0"
        "$mod, F, togglefloating"
        "$mod, G, togglegroup"
        "$mod, return, exec, fuzzel --hide-before-typing --lines 3"
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
          plugin {
          	hyprwinwrap {
          		# class is an EXACT match and NOT a regex!
          		class = GLava
          	}
          	hyprexpo {
          		columns = 5
          		gap_size = 5
          		bg_col = rgb(111111)
          		workspace_method = center current # [center/first] [workspace] e.g. first 1 or center m+1

          		enable_gesture = true # laptop touchpad
          		gesture_fingers = 4  # 3 or 4
          		gesture_distance = 300 # how far is the "max"
          		gesture_positive = true # positive = swipe down. Negative = swipe up.
          	}
      overview {
      	onBottom = true
      	panelColor = rgba(0, 0, 0, 0.3)
      	panelBorderColor = rgba(255, 255, 255, 0.2)
      	workspaceActiveBorder = rgba(255, 255, 255, 0.5)
      	centerAligned = true
      	workspaceBorderSize = 4
      	workspaceMargin = 5
      	panelHeight = 70
      	drawActiveWorkspace = true
      	overrideGaps = true
      	gapsIn = 15
      	gapsOut = 20
      	disableBlur = true
      	showNewWorkspace = true
      	showEmptyWorkspace = true
      }
          }
    '';
    plugins = with pkgs.hyprlandPlugins; [
      hyprspace
    ];
  };
}
