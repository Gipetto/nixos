{ config, pkgs, lib, ... }:
{
  programs.zsh.enable = true;
  
  home.username = "shawn";
  home.homeDirectory = "/home/shawn";
}
