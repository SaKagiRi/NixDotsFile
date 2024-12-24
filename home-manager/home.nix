{ pkgs, lib, ... }:

{
  home.username = "knakto";
  home.homeDirectory = "/home/knakto";
  home.stateVersion = "24.11";
  imports = [
    ./conf/neovim.nix
    ./conf/terminal.nix
  ];
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "obsidian"
	"steam-unwrapped"
	"steam"
  ];
  home.packages = with pkgs; [
    neofetch
    vesktop
	obsidian
    nixd
    clang
    clang-tools
	xwayland
	miru
  ];
  programs.home-manager.enable = true;
}
