{ config, pkgs, nixpkgs, ... }:
{
  nix.useDaemon = true;
  nixpkgs.hostPlatform = "aarch64-darwin";
  programs.zsh.enable = true;
  users.users.shawn.home = /Users/shawn;
}
