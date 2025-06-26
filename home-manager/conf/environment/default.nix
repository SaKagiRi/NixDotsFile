{
  config,
  pkgs,
  ...
}: {
  home.sessionVariables = {
    XDG_DATA_DIRS = "/var/lib/flatpak/exports/share:/home/knakto/.local/share/flatpak/exports/share:/usr/local/share:/usr/share";
    EDITOR = "nvim";
    NIXPKGS_ALLOW_UNFREE = 1;
    XMODIFIERS = "@im=fcitx";
    GTK_IM_MODULE = "";
    QT_IM_MODULE = "";
  };
}
