{...}: {
  system.autoUpgrade = {
    enable = true;
    operation = "switch"; # If you don't want to apply updates immediately, only after rebooting, use `boot` option in this case
    flake = "/home/knakto/knakto/Nix";
    flags = ["--update-input" "nixpkgs" "--update-input" "rust-overlay" "--commit-lock-file"];
    dates = "weekly";
  };
}
