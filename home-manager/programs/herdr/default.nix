{ pkgs, ... }:

let
  herdrPackage = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "herdr";
    version = "0.9.3";
    src = pkgs.fetchurl {
      url = "https://github.com/herdrdev/herdr/releases/download/v${version}/herdr-macos-aarch64";
      hash = "sha256-UXOj4K5C1dGrfr+l1eYyn3w9I/jho2d8fOMjHaKIQVc=";
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
