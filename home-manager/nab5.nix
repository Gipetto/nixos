{ config, pkgs, ... }:
{
  imports = [ ./common.nix ];

  home = {
    username = "shawn";
    homeDirectory = "/home/shawn";
    stateVersion = "26.05";
  };

  home.packages = with pkgs; [];
}
