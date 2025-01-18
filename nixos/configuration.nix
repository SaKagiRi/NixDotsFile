# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, outputs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./conf/stylix.nix
      ./conf/steam.nix
    ];

 nixpkgs = {
	overlays = [
		outputs.overlays.additions
	];
};

	programs.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.x86_64-linux.hyprland;
	};

	hardware = {
		opengl.enable = true;
	};

	services.displayManager = {
		sddm = {
			enable = true;
			wayland.enable = true;
		};
		autoLogin = {
			enable = true;
			user = "knakto";
		};
	};

fonts.packages = with pkgs; [
	noto-fonts
	noto-fonts-cjk-sans
	noto-fonts-emoji
	liberation_ttf
	fira-code
	fira-code-symbols
	mplus-outline-fonts.githubRelease
	dina-font
	proggyfonts
];

	boot.kernelPackages = pkgs.linuxPackages; # (this is the default) some amdgpu issues on 6.10
	hardware.xone.enable = true; # support for the xbox controller USB dongle
	services.getty.autologinUser = "knakto";
	environment.loginShellInit = ''
			[[ "$(tty)" = "/dev/tty1" ]] && ./gs.sh
			'';

	#services.throttled.enable = lib.mkDefault true;
	#hardware.graphics.extraPackages32.enable = true;
	hardware.graphics.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-72d63459-5a02-4c2a-8d0b-631f45c1464e".device = "/dev/disk/by-uuid/72d63459-5a02-4c2a-8d0b-631f45c1464e";
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Bangkok";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "th_TH.UTF-8";
    LC_IDENTIFICATION = "th_TH.UTF-8";
    LC_MEASUREMENT = "th_TH.UTF-8";
    LC_MONETARY = "th_TH.UTF-8";
    LC_NAME = "th_TH.UTF-8";
    LC_NUMERIC = "th_TH.UTF-8";
    LC_PAPER = "th_TH.UTF-8";
    LC_TELEPHONE = "th_TH.UTF-8";
    LC_TIME = "th_TH.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = false;

  # Enable the XFCE Desktop Environment.
  #services.xserver.displayManager.lightdm.enable = false;
  #services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  #services.xserver.xkb = {
  #  layout = "us";
  #  variant = "";
  #};

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  #hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.knakto = {
    isNormalUser = true;
    description = "Kasichon Nakto";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    wayland
    hyprland
    home-manager
    osu-lazer-bin-latest
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  hardware.opentabletdriver.enable = true;

}
