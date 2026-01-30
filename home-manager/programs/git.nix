{ config, lib, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "Shawn Parker";
    userEmail = "shawn@topfroggraphics.com";
    extraConfig = {
      core.excludesfile = "${../../config/gitignore}";
      include.path = "${../../config/gitconfig}";
    };
  };
}
