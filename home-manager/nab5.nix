{ config, pkgs, ... }:
{
  imports = [ ./common.nix ];

  home = {
    username = "shawn";
    homeDirectory = "/home/shawn";
    stateVersion = "23.11";
  };

  home.packages = with pkgs; [];
}
