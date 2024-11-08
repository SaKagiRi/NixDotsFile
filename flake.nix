{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
  let
	pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in
  {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    nixosConfigurations = {
	nixos = nixpkgs.lib.nixosSystem {
	modules = [
	 ./Nixconf/configuration.nix
	 #home-manager.nixosModules.home-manager

	 { environment.systemPackages = (with pkgs; [
		htop
		curl
		neovim
		nodejs_22
	  ]) ++ ([
		
	  ]);}

	];
	};
    };

  };
}
