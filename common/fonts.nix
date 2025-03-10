{ config, pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      hasklig
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];
  };
}
