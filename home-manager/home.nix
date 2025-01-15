{
  nixpkgs,
  config,
  pkgs,
  lib,
  ...
}:
{

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
	"copilot.vim"
  ];
  imports = [
    ./conf/neovim.nix
    ./conf/tmux.nix
    ./conf/zsh.nix
    ./conf/git.nix
    ./conf/fastfetch.nix
	./conf/environment.nix
	./conf/kitty.nix
  ];
  home = {
    username = "knakto";
    homeDirectory = "/home/knakto";
    stateVersion = "24.11";
    packages = with pkgs;[
	pciutils
	libGL
	mesa
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
	fzf
	zoxide
	bat
	tldr
	xwayland
	hyprland
	wayland
	cargo
	zip
	unzip
    ];
  };
}
