{ config, pkgs, ... }:
{
  fonts.fonts = with pkgs; [
    hasklig
    (nerfonts.override { fonts = [ "Meslo" ]; })
  ];
}
