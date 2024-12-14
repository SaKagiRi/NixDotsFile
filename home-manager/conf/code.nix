{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  programs.vscode = {
    enable = true;
    #package = pkgs.vscodium;
    package = pkgs.vscode;
    extensions = (with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
      bbenoist.nix
      jnoortheen.nix-ide
      #dsznajder.es7-react-js-snippets
      esbenp.prettier-vscode
      ms-vscode-remote.remote-ssh
      mhutchie.git-graph
      oderwat.indent-rainbow
      pkief.material-icon-theme
      bierner.markdown-emoji
      bierner.emojisense
    ]);/* ++ (with pkgs.unstable.vscode-extensions; [
      # Unstable
      seatonjiang.gitmoji-vscode
    ]);*/
  }; 
}
