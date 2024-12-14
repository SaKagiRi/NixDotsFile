{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plugin-onedark = {
      url = "github:navarasu/onedark.nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let
	lib = nixpkgs.lib;
	pkgs = nixpkgs.legacyPackages.x86_64-linux;
	app = with pkgs; [ htop neovim fastfetch vesktop gparted gcc kitty brave home-manager wget git ];
	program = with pkgs; [ distrobox docker podman python3 ruby gnumake42 devbox ];
  in
  {
    homeConfigurations = {
	knakto = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;
	modules = [ ./home-manager/home.nix ];	
        extraSpecialArgs = { inherit inputs; };
	};
    };
    nixosConfigurations = {
	nixos = lib.nixosSystem {
	   system = "x86_64-linux";
	   modules = [
		./nixos/configuration.nix
		home-manager.nixosModules.home-manager
		{
		hardware.bluetooth = {
			enable = true;
			powerOnBoot = true;
		};
		environment.systemPackages = (app) ++ (program); #(game);
		}
	   ];
	};
    };

  };
}
