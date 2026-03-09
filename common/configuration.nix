{ config, pkgs, lib, ... }:
{
  nix = {
    optimise.automatic = true;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      log-level = "error";
    };
  };

  environment = {
    variables = {
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
