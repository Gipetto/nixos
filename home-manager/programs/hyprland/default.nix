{ config, lib, pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  home.packages = with pkgs; [
    hyprlauncher # possibly configure separately later on
    kitty
  ];

  wayland.windowManager.hyprland = {
    enable = true;
  };

  xdg.configFile."hypr/hyprland.conf" = ./hyprland.conf;
}
