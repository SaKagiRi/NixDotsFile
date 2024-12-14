{ config, pkgs, inputs, lib, ... }:
let
  #...
in
{
  imports = [
    ./conf/shell.nix
    ./conf/vim.nix
    ./conf/tmux.nix
    ./conf/code.nix
    ./conf/nvim.nix
  ];

  home.username = "knakto";
  home.homeDirectory = "/home/knakto";

  home.packages = with pkgs; [
  	valgrind
    tree
    wine
    yazi
    hyprland
    lazygit
    zip
    openssh
    lighttpd
    putty
    # gcc
	clang
    glibc.static
    nasm
	fzf
	bat
	tldr
	zoxide
	cmatrix
	remmina
  ];

  programs.git = {
    enable = true;
    userName = "kita";
    userEmail = "kasichonooo@gmail.com";
    extraConfig = ''
      [PUSH]
       default = current
    '';
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  home.enableNixpkgsReleaseCheck = false;
}
