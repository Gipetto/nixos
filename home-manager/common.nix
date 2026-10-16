{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    bash
    bat
    btop
    curl
    fd
    gh
    gnumake
    jq
    lazygit
    nil          # nix LSP
    nixpkgs-fmt  # nix formatter
    svelte-language-server
    # pnpm includes platform-specific optional dependencies.
    (typescript-language-server.overrideAttrs (_finalAttrs: previousAttrs: {
      pnpmDeps = previousAttrs.pnpmDeps.override {
        hash = if pkgs.stdenv.hostPlatform.isLinux
          then "sha256-xR/EF60lVBsITKgH7wCM2wHM46PFQevD51KfCENSUH4="
          else "sha256-PmyJb8090pEPc09Tbv8RgdvQpzpba2L8ve87+aVncQU=";
      };
    }))
    vscode-langservers-extracted
    ripgrep
    sqlite
    uv
    wget
    yq
    (writeShellScriptBin "vim" "exec nvim \"$@\"")
  ];

  imports = [
    ./programs/git.nix
    ./programs/tmux.nix
    ./programs/vim
    ./programs/zsh
  ];

  programs.fzf = {
    enable = true;
  };

  programs.bat = {
    enable = true;
    config = {
      color = "always";
      theme = "Coldark-Cold";
      italic-text = "always";
      map-syntax = [
        ".zshrc.local:sh"
      ];
    };
  };

  programs.eza = {
    enable = true;
    extraOptions = [
      "--classify"
      "--long"
      "--header"
      "--time-style=long-iso"
      "--icons=always"
      "--color=auto"
    ];
    git = true;
    icons = "auto";
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.jq.enable = true;
  programs.nix-index.enable = true;
  programs.yazi = {
    enable = true;
    shellWrapperName = "yy";
  };

  home.file.".config/curl/curlrc".source = ./programs/curl/curlrc;
  home.file.".wgetrc".source = ./programs/wget/wgetrc;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
    config = {
      global = {
      log_format = "-";
      log_filter = "^$";
      };
      whitelist = {
      prefix = [ "~/Projects" ];
      };
    };
  };

  programs.home-manager.enable = true;

  manual.manpages.enable = false;
  news.display = "silent";
}
