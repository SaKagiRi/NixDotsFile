{...}: {
  services.xserver = {
    enable = true;
    xkb.layout = "us, th";
    xkbOptions = "grp:win_space_toggle";
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
}
