{...}: {
  imports = [
    ./package.nix
  ];
  services = {
    xserver.enable = true;
    xkb.layout = "us, th";
    xkbOptions = "grp:win_space_toggle";
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
  };
}
