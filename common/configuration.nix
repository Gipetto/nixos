{ config, pkgs, lib, ... }:
{
  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  environment = {
    variables = {
      VISUAL = "vim";
      PAGER = "less";
      LESS = "-eFRX";
    };

    systemPackages = with pkgs; [
      git
      screen
      wget
      ((vim-full.override { }).customize {
        # Contains duplicate declarations from `home-manager/shawn.nix`
        # so that the root user get the same nicities.
        vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
          start = [
            vim-nix
            vim-better-whitespace
          ];
          opt = [];
        };
        vimrcConfig.customRC = builtins.readFile ../config/vimrc;
      })
    ];
  };

  programs.zsh.enable = true;
}
