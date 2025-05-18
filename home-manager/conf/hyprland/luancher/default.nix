{pkgs, ...}: {
  # programs.rofi = {
  #   enable = true;
  #   location = "center";
  #   theme = "material";
  #   plugins = [
  #     pkgs.rofi-calc
  #     pkgs.rofi-emoji
  #     pkgs.rofi-systemd
  #   ];
  # };
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=6";
        width = "15";
        lines = "4";
        dpi-aware = "yes";
        anchor = "center";
      };
      colors = {
        background = "282828dd";
        text = "ffffff";
        match = "89b4fa";
        selection = "1e1e2e";
        selection-text = "ffffff";
        border = "89b4fa";
      };

      borders = {
        width = "2";
        radius = "10";
      };
    };
  };
}
