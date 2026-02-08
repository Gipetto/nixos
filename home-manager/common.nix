{ config, pkgs, home-manager }:
{
  # Base config that can be used on the server

  home.stateVersion = "23.11";
  home.packages = with pkgs; [
    bat
    btop
    wget
  ];

  imports = [
    ./programs/git
    ./programs/tmux.nix
    ./programs/vim
    ./programs/zsh
  ];

  home.file.".curlrc".source = ../config/curlrc;
  home.file.".wgetrc".source = ../../config/wgetrc;

  programs.bat = {
    enable = true;
    config = {
      theme = "Coldark-Cold";
      italic-text = "always";
    };
  };

  programs.eza = {
    enable = true;
    extraOptions = [
      "--classify"
      "--long"
      "--header"
      "--time-style=long-iso"
    ];
    git = true;
    icons = "auto";
  };

  programs.jq.enable = true;
  programs.nix-index.enable = true;
} 