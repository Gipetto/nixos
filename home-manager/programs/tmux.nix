{ config, pkgs, home-manager, ... }:
{
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

      # shortcut ctrl-b X to kill the session
      bind X kill-session

      set -g pane-border-lines heavy
      set -g pane-border-indicators arrows

      # vi-style copy mode
      set-window-option -g mode-keys vi
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi V send-keys -X select-line
      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
    '';
  };
}
