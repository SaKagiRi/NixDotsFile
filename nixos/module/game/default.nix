{pkgs, ...}: {
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraPackages = with pkgs; [
      gamescope
      proton-ge-bin
    ];
  };
  environment.systemPackages = with pkgs; [
    heroic
    gamemode
    protonup
    mangohud
    goverlay
  ];
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/knakto/.steam/root/compatibilitytools.d";
  };
}
