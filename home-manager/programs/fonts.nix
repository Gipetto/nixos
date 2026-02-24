{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    font-awesome
    nerd-fonts.jetbrains-mono
  ];
}
