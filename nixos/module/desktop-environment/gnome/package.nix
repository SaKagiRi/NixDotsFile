{pkgs, ...}: {
  imports = [ ./package.nix ./bind.nix ];
  environment.systemPackages = with pkgs; [
    gnome-console
    gnome-tour
  ];
}
