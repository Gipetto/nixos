{ config, pkgs, home-manager, ... }:
{
  # Can I use a variable to link this to the global nixos version?
  # From what I understand they need to stay in sync.
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    htop
    pipenv
    python311
    wget
  ];

  # Apparently shouldn't set this in this manner while
  # also using `home-manager.userGlobalPkgs`
  #nixpkgs.config.allowUnfree = true;

  #direnv.enable = true;

  imports = [
    ./programs/tmux.nix
    ./programs/zsh
  ];

  home.file.".curlrc".source = ../config/curlrc;
  home.file.".wgetrc".source = ../config/wgetrc;
  #home.file.".vim/vimrc".source = ../config/vimrc;

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

  # programs.vscode = {
  #   enable = true;

  #   userSettings = {
  #     "editor.formatOnSave" = true;
  #     "editor.tabSize" = 2;
  #     "files.insertFinalNewline" = true;
  #     "debug.javascript.autoAttachFilter": "disabled";
  #     "debug.javascript.automaticallyTunnelRemoteServer": false;
  #   };
  # };
}

