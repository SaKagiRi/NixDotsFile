{ config, pkgs, ... }:
let
  #...
in
{
  imports = [
    ./conf/shell.nix
    ./conf/vim.nix
  ];

  home.username = "knakto";
  home.homeDirectory = "/home/knakto";

  home.packages = with pkgs; [
    tree
    vim
    wine
  ];

  /*home.file = {
    ".vimrc".text = ''
	set number 
	set smartindent
	syntax enable
	colo elflord
	highlight LineNr ctermfg=LightGray
	highlight Comment ctermfg=Gray
	highlight String ctermfg=Green

	let g:user42 = 'knakto'
	let g:mail42 = 'knakto@student.42.fr'
	'';
    ".bashrc".text = ''
   	#alias vim="nvim"
	alias la='ls -la'
	'';
  };*/

  programs.git = {
    enable = true;
    userName = "kita";
    userEmail = "kasichonooo@gmail.com";
  };

  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  home.enableNixpkgsReleaseCheck = false;
}
