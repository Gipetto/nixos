{ config, lib, pkgs, ... }:
{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      vim-better-whitespace
    ];
    extraConfig = builtins.readFile ../../config/vimrc;
  };
}
