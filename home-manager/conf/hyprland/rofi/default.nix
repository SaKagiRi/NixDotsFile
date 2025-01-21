{	pkgs
,	...
}:
{
	programs.rofi = {
		enable = true;
		location = "center";
		theme = "material";
		plugins = [
				pkgs.rofi-calc
				pkgs.rofi-emoji
				pkgs.rofi-systemd
		];
		};
}
