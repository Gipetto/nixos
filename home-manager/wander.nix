{ config, pkgs, ... }:

let
  gdk = pkgs.google-cloud-sdk.withExtraComponents (with pkgs.google-cloud-sdk.components; [
    gcloud
  ]);
  # To update this pin, replace VERSION below and use its output for hash.
  # nix store prefetch-file --json "https://github.com/openai/codex/releases/download/rust-vVERSION/codex-package-aarch64-apple-darwin.tar.gz" | jq -r .hash
  codexPackage = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "codex";
    version = "0.145.0";
    src = pkgs.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-package-aarch64-apple-darwin.tar.gz";
      hash = "sha256-7Ok3Fp1MnpENYIJqbqSueEihbAiUA9Ei5w59pKxBujQ=";
    };
    sourceRoot = ".";
    installPhase = ''
      runHook preInstall
      cp -R . $out
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
