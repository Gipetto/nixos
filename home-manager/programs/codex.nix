{ pkgs, ... }:

let
  codexPackage = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "codex";
    version = "0.170.0";
    src = pkgs.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-package-aarch64-apple-darwin.tar.gz";
      hash = "sha256-l1UkvxOu3RsSLY0OAMCe5nCRuPaIwLN0lD27PPIseJM=";
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
