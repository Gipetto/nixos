{ config, pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      hasklig
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];
  };
}
