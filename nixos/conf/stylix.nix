{ pkgs, ... }:
{
	stylix = {
		base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
		image = ../../assets/background/City-Rainy-Night.png;
		polarity = "dark";
	};
}
