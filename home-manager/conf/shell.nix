{config, pkgs, ... }:
let
	als = {
		ll = "ls -l";
		la = "ls -la";
		".." = "cd ..";
	};
in
{
	programs.bash = {
	  enable = true;
	  shellAliases = als;
	};

	programs.zsh = {
	  enable = true;
	  shellAliases = als;
	};
}
