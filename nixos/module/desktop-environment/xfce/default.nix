{...}: {
  services.xserver = {
    enable = true;
    xkb.layout = "us, th";
    xkbOptions = "grp:win_space_toggle";
    displayManager.lightdm.enable = true;
    desktopManager.xfce.enable = true;
  };
}
