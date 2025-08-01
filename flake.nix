{
  description = "Nixflake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    stylix.url = "github:danth/stylix";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    swww.url = "github:LGFae/swww";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hycov = {
      url = "github:DreamMaoMao/hycov";
      inputs.hyprland.follows = "hyprland";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib;
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    package = import ./pkgs nixpkgs.legazyPackages.x86_64-linux;
    overlays = import ./overlays {inherit inputs;};
    homeConfigurations = {
      knakto = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        extraSpecialArgs = {inherit self inputs outputs;};
        modules = [
          inputs.nvf.homeManagerModules.default
          ./home-manager/home.nix
        ];
      };
    };

    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit self inputs outputs;};
        modules = [
          ./nixos/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          inputs.nix-flatpak.nixosModules.nix-flatpak
          inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x390
        ];
      };
    };
  };
}
