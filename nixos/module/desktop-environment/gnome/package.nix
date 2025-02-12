{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gnome-console
    gnome-tour
  ];
}
