{ config, pkgs, inputs, ... }:

let
  gdk = pkgs.google-cloud-sdk.withExtraComponents (with pkgs.google-cloud-sdk.components; [
    gcloud
  ]);
  codexMetadata = builtins.fromJSON (builtins.readFile "${inputs.codex-package}/codex-package.json");
  codexPackage = pkgs.stdenvNoCC.mkDerivation {
    pname = "codex";
    version = codexMetadata.version;
    src = inputs.codex-package;
    dontUnpack = true;
    installPhase = ''
      runHook preInstall
      mkdir -p $out
      cp -R "$src"/. "$out"
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
