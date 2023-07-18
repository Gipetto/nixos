{ config, pkgs, ... }:
{
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      hasklig
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];
  };
}
