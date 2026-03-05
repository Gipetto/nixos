{ config, pkgs, ... }:

let
  lib = pkgs.lib;
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git" 
        "git-prompt" 
        "ssh-agent" 
      ];
      theme = "wookiee";
      custom = "${config.home.homeDirectory}/.config/oh-my-zsh";
    };

    history = {
      size = 10000;
      save = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      extended = true;
      share = false;
    };

    shellAliases = {
      mv = "mv -v";
      rm = "rm -v";
      hyprkeys = "hyprkeys -t light";
    };

    localVariables = {
      PAGER = "less";
      LESS = "-eFRX";
      GIT_PS1_SHOWDIRTYSTATE = "true";
    };

    initContent = lib.mkMerge [
      # Runs early (before OMZ)
      (lib.mkBefore ''
        zstyle ":omz:update" mode reminder
        zstyle ":omz:module:git:alias" skip "yes"
        zstyle ":completion:*:make:*:targets" call-command true
        zstyle ":completion:*:*:make:*" tag-order "targets"
      '')

      # Main body
      ''
        export NODE_OPTIONS="--dns-result-order=ipv4first"
        setopt HIST_FCNTL_LOCK
        unsetopt SHARE_HISTORY
      ''

      # Darwin-specific
      (lib.optionalString pkgs.stdenv.isDarwin ''
        export IS_MAC=1
      '')

      # Linux-specific
      (lib.optionalString pkgs.stdenv.isLinux ''
        export IS_LINUX=1
        export ZSH_DISABLE_COMPFIX=true
        if command -v lspci >/dev/null 2>&1 && lspci | grep -q "NVIDIA"; then
          export WLR_RENDERER=vulkan
        fi
      '')

      # Runs last (after everything else)
      (lib.mkAfter ''
        if [[ -f "${config.home.homeDirectory}/.zshrc.local" ]]; then
          source "${config.home.homeDirectory}/.zshrc.local"
        fi
      '')
    ];
  };

  home.file.".config/oh-my-zsh/themes/wookiee.zsh-theme".source = ./wookiee.zsh-theme;

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];
}
