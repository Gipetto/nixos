{ config, pkgs, home-manager, ... }:
{
  # Can I use a variable to link this to the global nixos version?
  # From what I understand they need to stay in sync.
  home.stateVersion = "23.05";

  home.packages = with pkgs; [
    bat
    exa
    git
    htop
    wget
  ];

  imports = [
    ./zsh.nix
  ];

  home.file.".curlrc".source = ../config/curlrc;
  home.file.".wgetrc".source = ../config/wgetrc;

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Shawn Parker";
    userEmail = "shawn@topfroggraphics.com";
    extraConfig = {
      core.excludesfile = "${../config/gitignore}";
      include.path = "${../config/gitconfig}";
    };
  };

  programs.exa = {
    enable = true;
    extraOptions = [
      "--classify"
      "--long"
      "--header"
      "--time-style=long-iso"
    ];
    git = true;
    icons = true;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Coldark-Cold";
      italic-text = "always";
    };
  };

  programs.jq.enable = true;

  # Contains duplicate declarations from `common/configuration.nix` 
  # so that the root user gets the same nicities.
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
    ];
    extraConfig = builtins.readFile ../config/vimrc;
  };
}

