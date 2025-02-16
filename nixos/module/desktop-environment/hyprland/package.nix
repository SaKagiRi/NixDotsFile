{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
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
