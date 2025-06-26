{
  lib,
  self,
  ...
}: let
  current_wallpaper = "${self}/home-manager/conf/hyprland/background/random_wallpaper";
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 1;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = lib.mkForce [
        {
          path = "screenshot";
          # path = "${current_wallpaper}";
          blur_passes = 3; #3
          blur_size = 8; #8
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
}
