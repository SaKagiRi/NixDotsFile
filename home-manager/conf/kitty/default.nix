{lib, pkgs, ...}: {
  programs.kitty = {
    enable = true;
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+shift+h" = "previous_window";
      "ctrl+shift+j" = "previous_tab";
      "ctrl+shift+k" = "next_tab";
      "ctrl+shift+l" = "next_window";
      "ctrl+shift+p" = "next_layout";
      "ctrl+shift+t" = "new_tab_with_cwd";
    };
    extraConfig = lib.readFile ./kitty.conf;
  };
  home.packages = with pkgs; [
    fzf
    zoxide
    eza
    bat
    tldr
    zip
    unzip
  ];
}
