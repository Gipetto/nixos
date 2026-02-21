{ config, pkgs, unstable, ... }:

{
  imports = [ ./common.nix ];

  home.username = "shawn";
  home.homeDirectory = "/home/shawn";
  home.stateVersion = "23.11";

  # Server-specific packages (minimal, CLI only)
  home.packages = with pkgs; [
    htop
  ];

  # Note: nab5 is CLI only, so no Firefox/Hyprland/Waybar/VSCode configs
}
