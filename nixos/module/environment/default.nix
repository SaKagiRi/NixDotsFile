{pkgs, ...}: {
  # Setup Env Variables
  environment.variables = {
		# SPOTIFY_PATH = "${pkgs.spotify}/";
		LIBVA_DRIVER_NAME = "iHD";

	};
  # environment.variables.JDK_PATH = "${pkgs.jdk11}/";
  # environment.variables.NODEJS_PATH = "${pkgs.nodePackages_latest.nodejs}/";
}

