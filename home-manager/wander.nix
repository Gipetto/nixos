{ config, pkgs, ... }:

let
  gdk = pkgs.google-cloud-sdk.withExtraComponents (with pkgs.google-cloud-sdk.components; [
    gcloud
  ]);
  # Update hashes: version=0.144.0
  #   for asset in codex codex-code-mode-host; do nix store prefetch-file --json "https://github.com/openai/codex/releases/download/rust-v$version/$asset-aarch64-apple-darwin.tar.gz" | jq -r .hash; done
  # NOTE: two hashes to update (codex + codex-code-mode-host), both from the same
  # rust-v${version} tag. The code-mode-host helper is the command bridge codex
  # spawns as a sibling binary; omitting it breaks all tool execution at runtime.
  codexPackage = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "codex";
    version = "0.144.0";
    src = pkgs.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-aarch64-apple-darwin.tar.gz";
      hash = "sha256-EOBiMgskYkJReJdsoTjVXGCCFziZ3kcjCF3cYGa0koQ=";
    };
    # Command bridge helper; codex resolves it as a sibling of its own binary.
    codeModeHost = pkgs.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${version}/codex-code-mode-host-aarch64-apple-darwin.tar.gz";
      hash = "sha256-bPkoJDC+/lQTacfLKARgSn8N2UFvOjJB42dtsiAiokY=";
    };
    sourceRoot = ".";
    installPhase = ''
      runHook preInstall
      install -Dm755 codex-aarch64-apple-darwin $out/bin/codex
      tar -xzf $codeModeHost
      install -Dm755 codex-code-mode-host-aarch64-apple-darwin $out/bin/codex-code-mode-host
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
