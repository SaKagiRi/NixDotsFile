{	lib
,...
}:
{
	programs.kitty = {
	  enable = true;
	  extraConfig = lib.readFile ./kitty.conf;
	};
}
