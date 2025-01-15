{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
	url = "github:nix-community/home-manager";
	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs:
  let
	inherit (self) outputs;
	lib = nixpkgs.lib;
	pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in
{

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    package = import ./pkgs nixpkgs.legazyPackages.x86_64-linux;

    overlays = import ./overlays { inherit inputs; };

    homeConfigurations = {
	    knakto = home-manager.lib.homeManagerConfiguration {
			pkgs = pkgs;
		    extraSpecialArgs = { inherit inputs outputs; };
		    modules = [ ./home-manager/home.nix ];	
	    };
    };

    nixosConfigurations = {
	nixos = lib.nixosSystem {
		system = "x86_64-linux";
		specialArgs = {inherit inputs outputs;};
		modules = [
			./nixos/configuration.nix
			home-manager.nixosModules.home-manager
			nixos-hardware.nixosModules.lenovo-thinkpad-x390
			{
				hardware.bluetooth = {
					enable = true;
					powerOnBoot = true;
				};
			}
		];
	};
    };
};
}

