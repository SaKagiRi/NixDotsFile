{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let
	lib = nixpkgs.lib;
	pkgs = nixpkgs.legacyPackages.x86_64-linux;
	app = with pkgs; [ htop neovim fastfetch vesktop gparted gcc kitty brave home-manager vim wget git ];
	program = with pkgs; [ distrobox docker podman vscodium python3 ruby gnumake42 devbox ];
	#game = with pkgs; [ wine lutris-free ];
  in
  {

    #Packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    #packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    homeConfigurations = {
	knakto = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;
	modules = [ ./home-manager/home.nix ];	
	};
    };
    nixosConfigurations = {
	nixos = lib.nixosSystem {
	   system = "x86_64-linux";
	   modules = [
		./nixos/configuration.nix
		home-manager.nixosModules.home-manager
		#{
		#home-manager.useGlobalPkgs = true;
		#home-manager.useUserPackages = true;
		#home-manager.users.knakto = import ./home-manager/home.nix;
		#}
		{
		hardware.bluetooth = {
			enable = true;
			powerOnBoot = true;
		};
		#hardware.opengl.enable = true;
		environment.systemPackages = (app) ++ (program); #(game);
		}
	   ];
	};
    };

  };
}
