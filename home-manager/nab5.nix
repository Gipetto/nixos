{ config, pkgs, ... }:
{
  imports = [ ./common.nix ];

  home = {
    username = "shawn";
    homeDirectory = "/home/shawn";
    stateVersion = "26.05";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs; 
    };
    backupFileExtension = "bkp";
  };

  home.packages = with pkgs; [];
}
