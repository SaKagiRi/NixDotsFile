{
  pkgs,
  lib,
  ...
}: let
  module = ./conf;
  neovim = "nvf"; #nvf, neovim;
in {
  programs = {
    tmux.enable = lib.mkForce false;
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "copilot.vim"
      "steam"
      "steam-original"
      "steam-unwrapped"
      "steam-run"
      "steamcmd"
      "google-chrome"
      "minecraft-launcher"
      "android-studio-stable"
      "vscode"
      "obsidian"
    ];
  nixpkgs.config.allowBroken = true;
  imports = [
    "${module}/tmux"
    "${module}/shell"
    "${module}/git"
    "${module}/fastfetch"
    "${module}/environment"
    "${module}/kitty"
    "${module}/hyprland"
    "${module}/${neovim}"
    "${module}/drawing"
  ];
  home = {
    username = "knakto";
    homeDirectory = "/home/knakto";
    stateVersion = "24.11";
    packages = with pkgs; [
      jq
      google-chrome
      obsidian
      nemo
      paleta
      networkmanagerapplet
      libreoffice
      openvpn
      strongswan
      xl2tpd
      networkmanager-l2tp
      nodejs_22
      valgrind
      networkmanager_dmenu
      pipx
      wayland-protocols
      killall
      nautilus
      handlr
      hyprshot
      pciutils
      libGL
      gnumake42
      cmake
      docker
      podman
      devbox
      gparted
      clang
      clang-tools
      vesktop
      nixd
      miru
      htop
      btop
      curl
      tree
      wine
      ripgrep
      python3
      hyprland
      wayland
      cargo
    ];
  };
}
