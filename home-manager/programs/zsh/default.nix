{ config, environment, pkgs, home-manager, ... }:
{
  programs.zsh = {
    enable = true;
    
    # Oh-My-Zsh declarative setup
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "git-prompt"
        "ssh-agent"
      ];
      theme = "wookiee"; 
      custom = "$HOME/.config/oh-my-zsh";
    };

    # History settings
    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      extended = true;
      share = false;
    };

    # Basic aliases
    shellAliases = {
      mv = "mv -v";
      rm = "rm -v";
    };

    # Environment variables
    localVariables = {
      VISUAL = "vim";
      EDITOR = "vim";
      PAGER = "less";
      LESS = "-eFRX";
      GIT_PS1_SHOWDIRTYSTATE = "true";
    };

    # Additional config like zstyle settings
	initContent = builtins.readFile ./zshrc;
  };

  home.file.".config/oh-my-zsh/themes/wookiee.zsh-theme".source = ./wookiee.zsh-theme;
}
