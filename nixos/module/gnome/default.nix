{pkgs, ...}: {
  ## Enable Gnome
  services.xserver.enable = true;
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
  };
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  ## Enable XFCE
  #services.xserver.displayManager.lightdm.enable = false;
  #services.xserver.desktopManager.xfce.enable = true;

  # # Gnome Exclude Packages
  # environment.gnome.excludePackages =
  #   (with pkgs; [
  #     gnome-terminal
  #     gnome-tour
  #   ])
  #   ++ (with pkgs.gnome; [
  #     gedit # text editor
  #     epiphany # web browser
  #     geary # email reader
  #     tali # poker game
  #     iagno # go game
  #     hitori # sudoku game
  #     atomix # puzzle game
  #   ]);
}
