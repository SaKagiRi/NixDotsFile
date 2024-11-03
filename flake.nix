{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
  let
  	system = "x86_64-linux";
  	pkgs = inputs.nixpkgs.legacyPackages.${system};
  in
  {
  
	packages.x86_64-linux.default = pkgs.hello;

	nixosConfigurations.sakagiri = inputs.nixpkgs.lib.nixosSystem {
	 inherit system;
	 modules = [
	  ({ config, pkgs, ... }: {environment.systemPackages = with pkgs; [
		vim
		tree
		git
		vscodium
		fastfetch
		neovim
		tmux
		wget
		vesktop
		miru
		brave
		curl
		rofi-wayland
		gcc
		roslyn
		wine
		notify-sharp
		pipx
		kitty
		sl
		cmatrix
		htop
	  ];
	  })
	  ./configuration.nix
	 ];
	};

  };
}
