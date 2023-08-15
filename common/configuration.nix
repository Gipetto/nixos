{ config, pkgs, lib, ... }:  
{
  nix = {
    settings = {
      auto-optimise-store = true;
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
      bat
      exa
      git
      htop
      python3
      screen
      wget
      ((vim_configurable.override { }).customize {
        # Contains duplicate declarations from `home-manager/shawn.nix`
        # so that the root user get the same nicities.
        vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
          start = [ vim-nix ];
          opt = [];
        };
        vimrcConfig.customRC = builtins.readFile ../config/vimrc;
      })
    ];
  };

  programs.zsh.enable = true;
}
