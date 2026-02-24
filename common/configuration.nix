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
      fzf
      git
      ripgrep
      screen
      wget
    ];
  };

  programs.zsh.enable = true;
}
