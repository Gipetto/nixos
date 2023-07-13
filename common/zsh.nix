{ config, pkgs, home-manager, ... }:
{
  programs.zsh = {
    enable = true;
   
    shellAliases = {
      ls = "exa";
      mv = "mv --verbose";
      rm = "rm --verbose";
    };

    localVariables = {
      VISUAL = "vim";
      PAGER = "less";
      LESS = "-eFRX";
      GIT_PS1_SHOWDIRTYSTATE = "true";
    };

    initExtra = ''
      # enable a `.zshrc.local` for ad-hoc config 
      # since this config is version controlled
      if test -f ~/.zshrc.local; then
        . ~/.zshrc.local
      fi
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git" 
      ];
      theme = "eastwood";
    };
  };
}
