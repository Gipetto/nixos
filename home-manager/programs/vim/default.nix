{ pkgs, ... }:
{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      fzf-vim
      vim-nix
      vim-better-whitespace
    ];
    extraConfig = builtins.readFile ./vimrc;
  };
}
