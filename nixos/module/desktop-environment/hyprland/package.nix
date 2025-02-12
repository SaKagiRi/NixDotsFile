{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    pyprland
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    # hyprpaper
    cool-retro-term
    starship
    helix
    qutebrowser
    zathura
    mpv
    imv
  ];
}
