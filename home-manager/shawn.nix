{ config, pkgs, home-manager, ... }:
{
  home.stateVersion = "23.11";

  imports = [
    ./common.nix
    ./programs/firefox
    ./programs/fonts.nix
    ./programs/hyprland
    ./programs/utils.nix
    ./programs/vlc.nix
    ./programs/vscode.nix
    ./programs/waybar
  ];
}
