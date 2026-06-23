{ config, pkgs, ... }:

let
  gdk = pkgs.google-cloud-sdk.withExtraComponents( with pkgs.google-cloud-sdk.components; [
    gcloud
  ]);
  # Update hash: version=0.142.0; nix store prefetch-file --json "https://github.com/openai/codex/releases/download/rust-v$version/codex-aarch64-apple-darwin.tar.gz" | jq -r .hash
  codexPackage = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "codex";
    version = "0.142.0";
    src = pkgs.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-aarch64-apple-darwin.tar.gz";
      hash = "sha256-2qREPEVfSBQ9dQkS+g+R17lFb6UpcvclvBJUrptaNkg=";
    };
    sourceRoot = ".";
    installPhase = ''
      runHook preInstall
      install -Dm755 codex-aarch64-apple-darwin $out/bin/codex
      runHook postInstall
    '';
  };
in
{
  imports = [
    ./programs/worktrunk.nix
  ];

  home.packages = with pkgs; [
    # biome
    claude-code
    codexPackage
    colima
    dbmate
    deno
    doppler
    gdk
    k9s
    kubectl
    kubectl-cnpg
    kubectl-doctor
    libpq
    mprocs
    nodejs_22
    pnpm
    postgresql
    yarn
  ];
}
