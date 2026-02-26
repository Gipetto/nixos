{ config, pkgs, ... }:

{
  imports = [ 
    ./common.nix 
  ];

  # macOS-specific packages (if any)
  home.packages = with pkgs; [
    # Add any macOS-specific tools here
  ];
}
