{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./common.nix
    ./programs/fonts.nix
	  ./programs/hyprland.nix
    ./programs/vscode.nix
	  ./programs/waybar
  ];

  home.username = "shawn";
  home.homeDirectory = "/home/shawn";
  home.stateVersion = "26.05";

  # Workstation-specific packages
  home.packages = with pkgs; [
    bibata-cursors
    firefox
    hyprlauncher
    vlc
    zoxide
  ];

	home.pointerCursor = {
		gtk.enable = true;
		name = "Bibata-Modern-Classic";
		package = pkgs.bibata-cursors;
		size = 24;
		hyprcursor.enable = true;
	};

  programs.kitty.enable = true;
  fonts.fontconfig.enable = true;
}
