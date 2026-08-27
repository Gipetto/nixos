{ pkgs, ... }:

let
  codexPackage = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "codex";
    version = "0.150.1";
    src = pkgs.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-package-aarch64-apple-darwin.tar.gz";
      hash = "sha256-PsrsHn3Xhz+sXlBVM2GKkqfjvxLeeGm2EwwOPMf69nc=";
    };
    sourceRoot = ".";
    installPhase = ''
      runHook preInstall
      mkdir -p "$out"
      cp -R . "$out"
      runHook postInstall
    '';
  };
in
{
  home.packages = [
    codexPackage
  ];
}
