{ pkgs, ... }:

let
  herdrPackage = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "herdr";
    version = "0.9.5";
    src = pkgs.fetchurl {
      url = "https://github.com/herdrdev/herdr/releases/download/v${version}/herdr-macos-aarch64";
      hash = "sha256-+3fCIyoFqANUITgsiUOS9BdOTjihjkivPdApAVfDp+I=";
    };
    dontUnpack = true;
    installPhase = ''
      runHook preInstall
      install -Dm755 "$src" "$out/bin/herdr"
      runHook postInstall
    '';
  };
in
{
  home.packages = [
    herdrPackage
  ];
  xdg.configFile."herdr/config.toml".source = ./config.toml;
}
