{
  outputs,
  lib,
  pkgs,
  ...
}: {
programs.neovim =
	let
		toLua = str: "lua << EOF\n${str}\nEOF\n";
	in
	{
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
		# plugins = with pkgs.vimPlugins; [
		# ];
		extraConfig = ''
			lua require('config.lazy')
			" set		autoindent
			set			smartindent
			set			noexpandtab
			" set		expandtab
			set			tabstop=4
			set			shiftwidth=4
			set			backspace=indent,eol,start
			" syntax	on
			set			nu
			set			list
			set			listchars+=space:⋅
			set			listchars+=tab:→\ 
			set			listchars+=eol:↴
			hi Pmenu		ctermfg=white ctermbg=black gui=NONE guifg=white guibg=black
			hi PmenuSel		ctermfg=white ctermbg=blue gui=bold guifg=white guibg=purple
		'';
	};
}
