{ pkgs, ... }:

let
  codexPackage = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "codex";
    version = "0.154.0";
    src = pkgs.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-package-aarch64-apple-darwin.tar.gz";
      hash = "sha256-QnynTAJwSeDNGjMNYR5/jR/g8etqbYWsFvYbzyy0pIU=";
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
