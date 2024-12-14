{config, pkgs, ... }:
let
	als = {
		ll = "ls -l";
		la = "ls -la";
        ".." = "cd ..";
        "tmuxs" = ''tmux -S ~/server/fedora'';
		cat="bat";
		man="tldr";
		cd="z";
        };
in
{
	programs.bash = {
	  enable = true;
          shellAliases = als;
          bashrcExtra = ''
            fastfetch
			eval "$(fzf --bash)"
			eval "$(zoxide init bash)"
        	'';
        };

	programs.zsh = {
		enable = true;
		shellAliases = als;
		plugins = [
			# {
			# name = "powerlevel10k";
			# src = pkgs.zsh-powerlevel10k;
			# file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
			# }
			# {
			# name = "powerlevel10k-config";
			# src = ./p10k-config;
			# file = "p10k.zsh";
			# }
		];
		oh-my-zsh = {
			enable = true;
			plugins = [ "git" ];
			#theme = "robbyrussell";
			# theme = "agnoster";
			theme = "fletcherm";
	         };
	       };
}
