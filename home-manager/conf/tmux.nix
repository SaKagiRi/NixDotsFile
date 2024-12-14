{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = ''
        set -g mouse on
        set -g mode-key vi
    ''; 
  };
}
