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
    '';
  };
}
