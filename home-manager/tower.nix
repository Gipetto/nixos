{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./common.nix
    ./programs/fonts.nix
    ./programs/ghostty
    ./programs/hypridle.nix
    ./programs/hyprland
    ./programs/hyprpaper
    ./programs/vscode.nix
	  ./programs/waybar
  ];

  home = {
    username = "shawn";
    homeDirectory = "/home/shawn";
    stateVersion = "23.11";
  };

  home.packages = with pkgs; [
    bibata-cursors
    firefox
    hyprlauncher
    inputs.hyprkeys.packages.${pkgs.stdenv.hostPlatform.system}.default
    lm_sensors
    nvtopPackages.nvidia
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

    settings = {
      "*" = {
        AddressFamily = "inet";
        AddKeysToAgent = "yes";
      };

      "github.com" = {
        User = "git";
        IdentityFile = "~/.ssh/id_rsa";
      };

      "top-frog top-frog.com" = {
        User = "gipetto1";
      };

      "WookieebookMax WookiebookMax" = {
        User = "shawnp";
        HostName = "WookiebookMax";
        SetEnv.TERM = "xterm-256color";
      };

      "nab5" = {
        SetEnv.TERM = "xterm-256color";
      };
    };
  };
}
