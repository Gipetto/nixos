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
    xdg-utils
    # maybe a bit hacky, but alias some common macos commands to linux equivalents
    (pkgs.writeShellScriptBin "pbcopy" ''exec wl-copy "$@"'')
    (pkgs.writeShellScriptBin "pbpaste" ''exec wl-paste "$@"'')
    (pkgs.writeShellScriptBin "open" ''exec xdg-open "$@"'')
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

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    extraConfig = "AddressFamily inet";

    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
      };

      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/id_rsa";
      };

      "top-frog" = {
        host = "top-frog top-frog.com";
        user = "gipetto1";
      };

      "WookiebookMax" = {
        host = "WookieebookMax WookiebookMax";
        user = "shawnp";
        hostname = "WookiebookMax";
        extraOptions.SetEnv = "TERM=xterm-256color";
      };

      "nab5" = {
        extraOptions.SetEnv = "TERM=xterm-256color";
      };
    };
  };
}
