{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    bat
    btop
    direnv
    wget
    zoxide
  ];

  home.file.".curlrc".source = ../../config/curlrc;
  home.file.".wgetrc".source = ../../config/wgetrc;
  
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

  programs.jq.enable = true;

  programs.bat = {
    enable = true;
    config = {
      theme = "Coldark-Cold";
      italic-text = "always";
    };
  };

  xdg.configFile."direnv/direnv.toml".source = ../../config/direnv/direnv.toml;

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
