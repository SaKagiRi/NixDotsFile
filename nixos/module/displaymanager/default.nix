{pkgs, ...}: {
  # Enable Display Manager
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
  #       user = "greeter";
  #     };
  #   };
  # };

  services.displayManager = {
    sddm = {
      enable = false;
      wayland.enable = true;
    };
    autoLogin = {
      enable = true;
      user = "knakto";
    };
  };

  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];
}
