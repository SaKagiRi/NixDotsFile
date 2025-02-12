{...}: {
  imports = [
    ./package.nix
    ./env.nix
    ./services.nix
  ];
  programs.hyprland.enable = true;
  programs.hyprland.xwayland.enable = true;
}
