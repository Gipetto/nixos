{ config, pkgs, home-manager, ... }:
{
  # Can I use a variable to link this to the global nixos version?
  # From what I understand they need to stay in sync.
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    bat
    btop
    eza
    wget
    zoxide
  ];

  imports = [
    ./programs/firefox
    ./programs/tmux.nix
    ./programs/vscode.nix
    ./programs/zsh
  ];

  home.file.".curlrc".source = ../config/curlrc;
  home.file.".wgetrc".source = ../config/wgetrc;

  # direnv.enable = true;
  xdg.configFile."direnv/direnv.toml".source = ../config/direnv/direnv.toml;


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

  programs.bat = {
    enable = true;
    config = {
      theme = "Coldark-Cold";
      italic-text = "always";
    };
  };

  programs.jq.enable = true;
  programs.nix-index.enable = true;

  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-better-whitespace
    ];
    extraConfig = builtins.readFile ../config/vimrc;
  };
}

