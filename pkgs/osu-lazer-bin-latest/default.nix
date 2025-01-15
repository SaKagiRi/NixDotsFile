{
  lib,
  pkgs,
  stdenv,
  fetchurl,
  fetchzip,
  appimageTools,
  makeWrapper,
}:

let
  pname = "osu-lazer-bin-latest";
  version = "latest";

  src =
    {
      aarch64-darwin = fetchzip {
        url = "https://github.com/ppy/osu/releases/latest/download/osu.app.Apple.Silicon.zip";
        hash = "sha256-GsnTxVpNk2RXHLET6Ugv0/ZOlq8RUkw2ZXqRjkU+dzw=";
        stripRoot = false;
      };
      x86_64-darwin = fetchzip {
        url = "https://github.com/ppy/osu/releases/latest/download/osu.app.Intel.zip";
        hash = "sha256-GsnTxVpNk2RXHLET6Ugv0/ZOlq8RUkw2ZXqRjkU+dzw=";
        stripRoot = false;
      };
      x86_64-linux = fetchurl {
        url = "https://github.com/ppy/osu/releases/latest/download/osu.AppImage";
        hash = "sha256-GsnTxVpNk2RXHLET6Ugv0/ZOlq8RUkw2ZXqRjkU+dzw=";
      };
    }
    .${stdenv.system} or (throw "osu-lazer-bin: ${stdenv.system} is unsupported.");

  meta = {
    description = "Rhythm is just a *click* away (AppImage version for score submission and multiplayer, and binary distribution for Darwin systems)";
    homepage = "https://osu.ppy.sh";
    license = with lib.licenses; [
      mit
      cc-by-nc-40
      unfreeRedistributable # osu-framework contains libbass.so in repository
    ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [
      gepbird
      stepbrobd
      Guanran928
    ];
    mainProgram = "osu!";
    platforms = [
      "aarch64-darwin"
      "x86_64-darwin"
      "x86_64-linux"
    ];
  };

  passthru.updateScript = ./update.sh;
in
if stdenv.hostPlatform.isDarwin then
  stdenv.mkDerivation {
    inherit
      pname
      version
      src
      meta
      passthru
      ;

    installPhase = ''
      runHook preInstall
      APP_DIR="$out/Applications"
      mkdir -p "$APP_DIR"
      cp -r . "$APP_DIR"
      runHook postInstall
    '';
  }
else
  appimageTools.wrapType2 {
    inherit
      pname
      version
      src
      meta
      passthru
      ;

    extraPkgs = pkgs: with pkgs; [ icu ];

    extraInstallCommands =
      let
        contents = appimageTools.extract { inherit pname version src; };
      in
      ''
        . ${makeWrapper}/nix-support/setup-hook
        mv -v $out/bin/${pname} $out/bin/osu!
        wrapProgram $out/bin/osu! \
          --set OSU_EXTERNAL_UPDATE_PROVIDER 1 \
		 --set LD_LIBRARY_PATH ${lib.makeLibraryPath (with pkgs; [
			wayland
			udev
			libudev-zero
		 ])}
        install -m 444 -D ${contents}/osu!.desktop -t $out/share/applications
        for i in 16 32 48 64 96 128 256 512 1024; do
          install -D ${contents}/osu.png $out/share/icons/hicolor/''${i}x$i/apps/osu.png
        done
      '';
  }
