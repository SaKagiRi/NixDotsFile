{pkgs, ...}: let
  bluetooth = with pkgs; [overskride];
  ssh = with pkgs; [mosh];
  hypr = with pkgs; [swww];
  sound = with pkgs; [
    pulseaudio
    pamixer
    pavucontrol
  ];
  game = with pkgs; [flatpak libportal];
  screen = with pkgs; [
	efibootmgr

    wlsunset
    brightnessctl

    #SCREENSHOT
    grim
    slurp
    wl-clipboard
  ];
  fetch-info = with pkgs; [
    neofetch
    onefetch
    ipfetch
    cpufetch
    ramfetch
    starfetch
    octofetch
    htop
    bottom
    btop
    zfxtop
    kmon
    glxinfo
    vulkan-tools
    vdpauinfo
    libva-utils
    nvtopPackages.nvidia
    nvtopPackages.intel
    wlr-randr
    gpu-viewer
    dig
    speedtest-rs
  ];
in {
  environment.systemPackages = bluetooth ++ fetch-info ++ screen ++ sound ++ game ++ ssh ++ hypr;
}
