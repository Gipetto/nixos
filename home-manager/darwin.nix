{ config, pkgs, ... }:

{
  imports = [ 
    ./common.nix 
    ./programs/firefox.nix
  ];

  home.username = "shawn";
  home.homeDirectory = "/Users/shawn";

  # macOS-specific packages (if any)
  home.packages = with pkgs; [
    # Add any macOS-specific tools here
  ];
}
