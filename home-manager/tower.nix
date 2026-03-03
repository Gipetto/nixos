{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./common.nix
    ./programs/fonts.nix
    ./programs/ghostty
	  ./programs/hyprland.nix
    ./programs/vscode.nix
	  ./programs/waybar
  ];

  home = {
    username = "shawn";
    homeDirectory = "/home/shawn";
    stateVersion = "26.05";
  };

  home.packages = with pkgs; [
    bibata-cursors
    firefox
    hyprlauncher
    inputs.hyprkeys.packages.${pkgs.stdenv.hostPlatform.system}.default
    vlc
    wl-clipboard
  ];

  # Damn you hyprland!
  # Why must I override your cursor?
	home.pointerCursor = {
		gtk.enable = true;
		name = "Bibata-Modern-Classic";
		package = pkgs.bibata-cursors;
		size = 24;
		hyprcursor.enable = true;
	};
}
