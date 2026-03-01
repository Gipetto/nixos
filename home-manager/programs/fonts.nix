{ config, pkgs, lib, inputs, ... }:
{
  home.packages = with pkgs; [
    font-awesome
    nerd-fonts.jetbrains-mono
    inputs.private-fonts.packages.${pkgs.stdenv.hostPlatform.system}.berkeley-mono
  ];

  fonts.fontconfig.enable = true;
}
