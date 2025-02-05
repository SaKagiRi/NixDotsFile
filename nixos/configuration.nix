{
  pkgs,
  outputs,
  ...
}:let
	module = ./module;
in{
  imports = [
    "${module}/sound"
    "${module}/user"
    "${module}/screen"
    "${module}/opengl"
    "${module}/mosh"
    "${module}/bluetooth"
    "${module}/displaymanager"
    "${module}/environment"
    "${module}/fingerprint-scanner"
    "${module}/firewall"
    "${module}/font"
    "${module}/garbage-collector"
    "${module}/gnome"
    "${module}/info-fetchers"
    "${module}/internationalisation"
    "${module}/auto-upgrade"
    "${module}/stylix"
    "${module}/game"
    "${module}/hyprland"
    "${module}/flatpak"
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
    ];
  };

  services.dbus.enable = true;


  # boot.kernelPackages = pkgs.linuxPackages; # (this is the default) some amdgpu issues on 6.10
  # hardware.xone.enable = true; # support for the xbox controller USB dongle
  # services.getty.autologinUser = "knakto";
  # environment.loginShellInit = ''
  #   [[ "$(tty)" = "/dev/tty1" ]] && ./gs.sh
  # '';

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
		#flatpak
    firefox
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  hardware.opentabletdriver.enable = true;

  system.stateVersion = "24.05";
}
