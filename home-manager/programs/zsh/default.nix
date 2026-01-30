{ config, pkgs, home-manager, ... }:
{
  programs.zsh = {
    enable = true;

    shellAliases = {
      mv = "mv -v";
      rm = "rm -v";
    };

    localVariables = {
      VISUAL = "vim";
      EDITOR = "vim";
      PAGER = "less";
      LESS = "-eFRX";
      GIT_PS1_SHOWDIRTYSTATE = "true";
    };

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
      ];
      theme = "wookiee";
      custom = "$HOME/.config/oh-my-zsh";
    };
  };

  programs.zsh.initContent = builtins.readFile ./init-extra.sh;

  home.file.".config/oh-my-zsh/themes/wookiee.zsh-theme".source = ./custom/wookiee.zsh-theme;
}
