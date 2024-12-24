{
    description = "Nixdora";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixvim.url = "github:nix-community/nixvim";
    };
    outputs = {
        nixpkgs,
        home-manager,
        nixvim,
        ...
    }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    in {
        nixpkgs.config.allowUnfree = true;
        packages.x86_64-linux.neovim = nixvim.packages.neovim;
        homeConfigurations = {
            knakto = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
                    ./home-manager/home.nix
                ];
            };
        };
    };
}


