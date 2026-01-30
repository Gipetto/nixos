{ config, pkgs, home-manager, ... }:
{
  # Can I use a variable to link this to the global nixos version?
  # From what I understand they need to stay in sync.
  home.stateVersion = "23.11";

  imports = [
    ./programs/firefox
    ./programs/git.nix
    ./programs/tmux.nix
    ./programs/utils.nix
    ./programs/vim.nix
    ./programs/vlc.nix
    ./programs/vscode.nix
    ./programs/zsh
  ];

  programs.home-manager.enable = true;
  programs.nix-index.enable = true;
}

