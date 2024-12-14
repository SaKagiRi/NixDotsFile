{ config, pkgs, ... }:
let
	conf = "''
    set number
	''";
in
{
        programs.vim = {
	enable = true;
	extraConfig = ''
	    set number
        set smartindent
        set expandtab
        syntax enable
        colo elflord
        highlight LineNr ctermfg=LightGray
        highlight Comment ctermfg=Gray
        highlight String ctermfg=Green

        let g:user42 = 'knakto'
        let g:mail42 = 'knakto@student.42.fr'
	'';
	};
}
