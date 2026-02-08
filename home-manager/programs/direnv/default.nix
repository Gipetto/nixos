{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    direnv
  ];

  xdg.configFile."direnv/direnv.toml".source = ./direnv.toml;
}