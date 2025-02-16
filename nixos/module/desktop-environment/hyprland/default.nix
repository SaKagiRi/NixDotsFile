{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./package.nix
    ./env.nix
    ./services.nix
  ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
}
