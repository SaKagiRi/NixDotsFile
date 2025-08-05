{pkgs, ...}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.knakto = {
    isNormalUser = true;
    description = "Kasichon Nakto";
    extraGroups = [ "docker" "networkmanager" "input" "wheel" "video" "audio" "tss" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # spotify
      #youtube-music
      #discord
      tdesktop
      #vscodium
      #brave
    ];
  };

  programs.zsh.enable = true;

  # Change runtime directory size
  services.logind.extraConfig = "RuntimeDirectorySize=8G";
}
