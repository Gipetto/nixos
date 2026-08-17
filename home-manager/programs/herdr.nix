{ pkgs, ... }:

let
  herdrPackage = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "herdr";
    version = "0.8.0";
    src = pkgs.fetchurl {
      url = "https://github.com/herdrdev/herdr/releases/download/v${version}/herdr-macos-aarch64";
      hash = "sha256-1Tqfk/zP38xVYyknv1EAL1rdCqeZC831CP+9hKxlgXg=";
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
