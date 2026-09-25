{ pkgs, ... }:

let
  codexPackage = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "codex";
    version = "0.157.0";
    src = pkgs.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-package-aarch64-apple-darwin.tar.gz";
      hash = "sha256-l4Cfkcs1XlVIDNehJvmtJLt7FiIiUV4wKGvKxvupSs0=";
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
