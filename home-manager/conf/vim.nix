{ config, pkgs, ... }:

{
	programs.vim = {
	  enable = true;
	 /* ".vimrc".text = ''
		set number
		set smartindent
	  '';*/
	};
}
