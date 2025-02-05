{...}: {
  home.file = {
    ".config/waybar/config".source = ./config;
    ".config/waybar/style.css".source = ./style.css;
    ".config/waybar/macchiato.css".source = ./macchiato.css;
  };
  programs.waybar = {
    enable = true;
  };
}
