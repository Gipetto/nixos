{ config, lib, pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Shawn Parker";
        email = "shawn@topfroggraphics.com";
      };
      core.excludesfile = "${./gitignore}";
      include.path = "${./gitconfig}";
    };
  };
}
