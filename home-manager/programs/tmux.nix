{ pkgs, inputs, ... }:
let
  palette = (import ../themes/birren-industrial { inherit pkgs; }).palette;
in
{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g @plugin 'jaclu/tmux-menus'

      set -g mouse on
      set -g default-terminal "tmux-256color"
      set -as terminal-overrides ",*:Tc"
      set-environment -g COLORTERM "truecolor"
      
      set-window-option -g aggressive-resize off

      set -g status-style 'bg=${palette.creamDark},fg=${palette.industrialCharcoal}'
      set -g status-left-style 'bg=${palette.seafoam},fg=${palette.industrialCharcoal},bold'
      set -g status-left ' #S '
      set -g status-right-style 'bg=${palette.creamDark},fg=${palette.industrialCharcoal}'
      set-window-option -g window-status-style 'bg=${palette.creamDark},fg=${palette.industrialCharcoal}'
      set-window-option -g window-status-format ' #I:#W#F '
      set-window-option -g window-status-current-style 'bg=${palette.dadoGreen},fg=${palette.industrialCharcoal},bold'
      set-window-option -g window-status-current-format ' #I:#W#F '

      # shortcut ctrl-b X to kill the session
      bind X kill-session

      # move to next available session when killing session
      set-option -g detach-on-destroy off

      set -g pane-border-lines heavy
      set -g pane-border-indicators arrows

      # vi-style copy mode
      set-window-option -g mode-keys vi
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi V send-keys -X select-line
      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      bind -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"

      run-shell ${inputs.tpm}/tpm
    '';
  };
}
