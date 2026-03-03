{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    bash
    bat
    btop
    bruno
    bruno-cli
    curl
    fd
    gh
    gnumake
    jq
    lazygit
    nil          # nix LSP
    nixpkgs-fmt  # nix formatter
    ripgrep
    sqlite
    wget
    yq
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
  programs.yazi.enable = true;

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
}
