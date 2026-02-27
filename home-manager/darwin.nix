{ config, pkgs, ... }:

{
  imports = [ 
    ./common.nix 
  ];

  home.packages = with pkgs; [
    _1password-cli
    docker-client
  ];
}
