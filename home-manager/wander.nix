{ config, pkgs, ... }:

let
  gdk = pkgs.google-cloud-sdk.withExtraComponents( with pkgs.google-cloud-sdk.components; [
    gcloud
  ]);
in
{
  home.packages = with pkgs; [
    biome
    claude-code
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
    opencode
    pnpm
    postgresql
    yarn
  ];
}
