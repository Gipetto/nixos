{ config, pkgs, ... }:
{
  imports = [ ./common.nix ];

  home = {
    username = builtins.getEnv "USER";
    homeDirectory = builtins.getEnv "HOME";
    stateVersion = "26.05";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bkp";
  };

  home.packages = with pkgs; [];
}
