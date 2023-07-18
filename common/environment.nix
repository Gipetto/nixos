{ config, pkgs, lib, ... }:
{
  environment = {
    variables = {
      VISUAL = "vim";
      PAGER = "less";
      LESS = "-eFRX";
    };

    systemPackages = with pkgs; [
      bat
      curl
      exa
      git
      gnumake
      htop
      rsync
      screen
      wget
      ((vim.override { }).customize {
        # Contains duplicate declarations from `home-manager/shawn.nix`
        # so that the root user get the same nicities.
        vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
          start = [ "vim-nix" ];
          opt = [];
        };
        vimrcConfig.customRC = builtins.readFile ../config/vimrc;
      })
    ];
  };

  programs.zsh.enable = true;
}
