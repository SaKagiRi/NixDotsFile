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
      "google-chrome"
      "minecraft-launcher"
      "obsidian"
      "steam"
      "steam-unwrapped"
      "unityhub"
    ];
  nixpkgs.config.allowBroken = true;
  imports = [
    # "${module}/tmux"
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
      networkmanager
      google-chrome
      obsidian
      vesktop
      killall
      handlr
      nemo		#file manager
      feh		#open picture
      valgrind
      pciutils	#lspci
      gparted
      miru
      xclicker
      prismlauncher
      lutris
      wine
      docker
      bear
      gnumake
      unityhub
      gnome-boxes
      docker-compose
      #--------------------------------#
      ripgrep
      libGL
      htop
      btop
      curl
      tree
      #--------------------------------#
      clang
      nixd
      python3
      pipx
      nodejs_22
      norminette
    ];
  };
}
