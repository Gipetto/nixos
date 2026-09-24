{ pkgs, ... }:

let
  herdrPackage = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "herdr";
    version = "0.9.1";
    src = pkgs.fetchurl {
      url = "https://github.com/herdrdev/herdr/releases/download/v${version}/herdr-macos-aarch64";
      hash = "sha256-X8en5636ylb6gKqJ3LAlaTNXJo2rgoW5zi0IojE8id4=";
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
}
