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
      zstyle ':omz:module:git:alias' skip 'yes'
      setopt hist_ignore_dups
      setopt hist_expire_dups_first
      setopt hist_ignore_space

      # configure makefile completion
      zstyle ':completion:*:make:*:targets' call-command true
      zstyle ':completion:*:*:make:*' tag-order 'targets'
    '';


    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "git-prompt"
        "pipenv"
      ];
      theme = "wookiee";
      custom = "$HOME/.config/oh-my-zsh";
    };
  };

  home.file.".config/oh-my-zsh/themes/wookiee.zsh-theme".source = ./custom/wookiee.zsh-theme;
}
