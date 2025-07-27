{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wayland-protocols
    wayland
    hyprland
    pyprland
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    cool-retro-term
    starship
    helix
    qutebrowser
    zathura
    mpv
    imv
  ];
}
