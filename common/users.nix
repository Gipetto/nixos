{ config, pkgs, ... }: 
{
  users = {
    defaultUserShell = pkgs.zsh;

    users.shawn = {
      isNormalUser = true;
      description = "Shawn Parker";
      extraGroups = [ "docker" "networkmanager" "wheel" ];
    };
  };
}
