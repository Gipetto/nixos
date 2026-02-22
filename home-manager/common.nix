{ config, pkgs, lib, ... }:

{
  # Core CLI packages
  home.packages = with pkgs; [
    # CLI essentials
    bat
    btop
    wget
    ripgrep
    fd
    jq
    fzf
    
    # Dev tools
    gh
    lazygit
    
    # Nix tooling
    nil          # nix LSP
    nixpkgs-fmt  # nix formatter
    
    # Dotfile management
    chezmoi
  ];

  # ============================================================
  # Programs with FULL nix config (NOT in chezmoi)
  # ============================================================
  
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
  programs.yazi.enable = true;

  # Tmux with full configuration (used on all hosts)
  programs.tmux = {
    enable = true;
    extraConfig = ''
      #set -g utf8
      #set-window-option -g utf8 on
      #set -g status-utf8 on
      set -g mouse on

      set -g default-terminal "xterm-256color"
      set-window-option -g aggressive-resize off
      #bind r source-file ~/.tmux.conf \; display-message "Config reloaded"

      # Use Ctrl-a to be more like screen
      #set -g prefix C-a
      #unbind C-b
      #bind C-a send-prefix

      # inactive windows in status bar
      set-window-option -g window-status-format '#[fg=cyan,dim]#I#[fg=blue]:#[default]#W#[fg=grey,dim]#F'
      # current or active window in status bar
      set-window-option -g window-status-current-format '#[bg=blue,fg=cyan,bold]#I#[bg=blue,fg=cyan]:#[fg=white]#W#[fg=dim]#F'

      #setw -g window-status-current-format "|#I:#W|"
    '';
  };

  # ============================================================
  # Programs ENABLED here but CONFIGURED in chezmoi
  # ============================================================
  
  # Git - config in chezmoi
  programs.git.enable = true;

  # Vim - config in chezmoi  
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-better-whitespace
    ];
    # vimrc content comes from chezmoi
  };

  # Direnv - config in chezmoi
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    # direnv.toml comes from chezmoi
  };

  # ZSH - oh-my-zsh setup here, runtime config in chezmoi
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
      theme = "wookiee";  # Theme file comes from chezmoi
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
    initExtra = ''
      export ZSH_DISABLE_COMPFIX=true
      zstyle ':omz:update' mode reminder
      zstyle ':omz:module:git:alias' skip 'yes'
      
      # Completion settings
      zstyle ':completion:*:make:*:targets' call-command true
      zstyle ':completion:*:*:make:*' tag-order 'targets'
      
      # Load runtime config from chezmoi
      if test -f ~/.zshrc.local; then
        . ~/.zshrc.local
      fi
    '';
  };

  # Enable home-manager to manage itself
  programs.home-manager.enable = true;

  # Chezmoi notification hook
  home.activation.checkChezmoi = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # Check if chezmoi is initialized
    if [ -d "$HOME/.local/share/chezmoi" ]; then
      # Check for differences
      if ! ${pkgs.chezmoi}/bin/chezmoi diff --exit-on-error > /dev/null 2>&1; then
        echo "⚠️  Chezmoi has uncommitted changes. Run 'chezmoi diff' to see them."
        echo "    Run 'chezmoi apply' to apply them."
      fi
    else
      echo "ℹ️  Chezmoi not initialized. Run:"
      echo "    chezmoi init --source ~/Projects/nixos/chezmoi https://github.com/Gipetto/nixos.git"
    fi
  '';
}
