{ config, pkgs, ... }:

{
  imports = [ ./common.nix ];

  home.username = "shawn";
  home.homeDirectory = "/home/shawn";
  home.stateVersion = "26.05";

  # Server-specific packages (minimal, CLI only)
  home.packages = with pkgs; [
    htop
  ];

  # Note: nab5 is CLI only, so no Firefox/Hyprland/Waybar/VSCode configs
}
