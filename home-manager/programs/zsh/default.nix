{ config, pkgs, home-manager, ... }:
{
  programs.zsh = {
    enable = true;
   
    shellAliases = {
      # ls = "exa";
      mv = "mv -v";
      rm = "rm -v";
    };

    localVariables = {
      VISUAL = "vim";
      PAGER = "less";
      LESS = "-eFRX";
      GIT_PS1_SHOWDIRTYSTATE = "true";
    };

    initExtra = ''
      # enable a `.zshrc.local` for ad-hoc config 
      # since this config is generated at build time
      if test -f ~/.zshrc.local; then
        . ~/.zshrc.local
      fi
    '';

    profileExtra = ''
      setopt hist_ignore_dups
      setopt hist_expire_dups_first
      setopt hist_ignore_space
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git" 
        "git-prompt"
      ];
      theme = "wookiee";
      custom = "$HOME/.config/oh-my-zsh";
    };
  };

  home.file.".config/oh-my-zsh/themes/wookiee.zsh-theme".source = ./custom/wookiee.zsh-theme;
}
