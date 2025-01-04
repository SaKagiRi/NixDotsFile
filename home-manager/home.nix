{ pkgs, lib, ... }:

{
  home.username = "knakto";
  home.homeDirectory = "/home/knakto";
  home.stateVersion = "24.11";
  imports = [
    ./conf/neovim.nix
    ./conf/zsh.nix
	./conf/git.nix
	./conf/fastfetch.nix
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
	htop
	fastfetch
		#git
	tmux
	wget
	curl
	cmatrix
	tree
	wine
	mesa
	glfw
	ripgrep
	python3
	fzf
	zoxide
	bat
	tldr
		#waydroid
		#steam
		#steam-run-native
	nodejs_22
  ];
  programs.home-manager.enable = true;
}
