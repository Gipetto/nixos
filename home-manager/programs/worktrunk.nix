{ pkgs, ... }: {
  home.packages = [ 
    pkgs.worktrunk 
  ];

  programs.zsh.initContent = ''
    source <(wt config shell init zsh)
  '';

  xdg.configFile."worktrunk/config.toml".text = ''
    worktree-path = "{{ repo_path }}/../{{ repo }}.{{ (branch | sanitize)[:35] }}"

    [pre-start]
    sync = "{% if base == default_branch %}git pull{% endif %}"

    [post-switch]
    copy = "echo -n {{ (branch | sanitize)[:25] }} | pbcopy"
  '';

  #   [post-start]
  #   tmux = """
  #     tmux new-session -d -s {{ (branch | sanitize)[:25] }} -c {{ worktree_path }} \\; \\
  #     send-keys 'claude' Enter \\; \\
  #     split-window -h -c {{ worktree_path }} \\; \\
  #     send-keys 'lazygit' Enter \\; \\
  #     split-window -v -c {{ worktree_path }} \\; \\
  #     select-pane -t 0
  #   """

  #   [pre-remove]
  #   tmux = "tmux kill-session -t {{ (branch | sanitize)[:25] }} 2>/dev/null || true"
  # '';
}
