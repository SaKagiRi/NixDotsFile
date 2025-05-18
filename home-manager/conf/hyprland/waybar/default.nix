{pkgs, ...}: {
  home.packages = with pkgs; [
    cava                   #audio on waybay
    swaynotificationcenter #swaync notification
  ];
  home.file = {
    ".config/waybar/config".source = ./config;
    ".config/waybar/style.css".source = ./style.css;
    ".config/waybar/Volume.sh".source = ../script/Volume.sh;
  };
  programs.waybar = {
    enable = true;
  };
}
