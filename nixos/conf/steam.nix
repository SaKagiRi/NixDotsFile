{ pkgs, ... }:
{
	programs.steam = {
		enable = true;
		extraPackages = with pkgs; [
			gamescope
			proton-ge-bin
		];
	};
}
