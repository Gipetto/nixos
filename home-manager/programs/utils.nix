{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    zoxide
  ];

  home.file.".curlrc".source = ../../config/curlrc;
  
  programs.eza = {
    enable = true;
    extraOptions = [
      "--classify"
      "--long"
      "--header"
      "--time-style=long-iso"
    ];
    git = true;
    icons = "auto";
  };
  
#   programs.ssh = {
#     enable = true;
#     matchBlocks = {
#       "github.com" = {
#         user = "git";
#         useKeychain = if pkgs.stdenv.isDarwin then "yes" else null;  
# 	extraConfig = ''
# 	  AddKeysToAgent yes
# 	'';
#       };
#       "nab5" = {
#         user = "shawn";
#         hostname = "nab5.wookiee.internal";
#       };
#       "tower" = {
#         user = "shawn";
#         hostname = "tower.wookiee.internal";
#       };
#       "*.ssh.wpengine.net" = {
#         addressFamily = "inet";
#       };
#     };
#   };
}
