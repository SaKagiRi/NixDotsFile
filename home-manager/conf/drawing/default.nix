{pkgs, ...}: {
  home.packages = with pkgs; [
    obs-studio
    openseeface
    inochi-creator
    krita
  ];
}
