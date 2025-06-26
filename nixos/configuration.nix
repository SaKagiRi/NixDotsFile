{
  lib,
  pkgs,
  outputs,
  ...
}: let
  module = ./module;
  desktop-environment = "hyprland"; # hyprland, plasma6, gnome, xfce;
in {
  imports =
    [
      ./hardware-configuration.nix
      ./package.nix
      ./services.nix
      ./bootloader.nix
      ./docker.nix
    ]
    ++ [
      "${module}/user"
      "${module}/firewall"
      "${module}/font"
      "${module}/internationalisation"
      "${module}/stylix"
      "${module}/game"
      # "${module}/flatpak"
    ]
    ++ [
      "${module}/desktop-environment/${desktop-environment}"
    ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
    ];
  };

  system.autoUpgrade = {
    enable = true;
    operation = "switch"; # If you don't want to apply updates immediately, only after rebooting, use `boot` option in this case
    flake = "/home/knakto/knakto/Nix";
    flags = ["--update-input" "nixpkgs" "--update-input" "rust-overlay" "--commit-lock-file"];
    dates = "weekly";
  };
  # Optimize storage and automatic scheduled GC running
  # If you want to run GC manually, use commands:
  # `nix-store --optimize` for finding and eliminating redundant copies of identical store paths
  # `nix-store --gc` for optimizing the nix store and removing unreferenced and obsolete store paths
  # `nix-collect-garbage -d` for deleting old generations of user profiles
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  boot.initrd.luks.devices."luks-72d63459-5a02-4c2a-8d0b-631f45c1464e".device = "/dev/disk/by-uuid/72d63459-5a02-4c2a-8d0b-631f45c1464e";
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnsupportedSystem = true;
  nixpkgs.config.allowBroken = true;

  environment.systemPackages = with pkgs; [
    wget
    wayland
    hyprland
    home-manager
    osu-lazer-bin-latest
    flatpak
    firefox
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  hardware.opentabletdriver.enable = true;

  system.stateVersion = "24.05";
}
