{ config, pkgs, ... }:

{
  imports = [ 
    ./common.nix 
  ];

  home = {
    username = builtins.getEnv "USER";
    homeDirectory = builtins.getEnv "HOME";
    stateVersion = "24.05";
  };

  # macOS-specific packages (if any)
  home.packages = with pkgs; [
    # Add any macOS-specific tools here
  ];
}
