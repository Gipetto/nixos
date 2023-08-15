{ config, pkgs, nixpkgs, ... }:
{
  nix = {
    useDaemon = true;
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 0;
        Minute = 0;
      };
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  programs.zsh.enable = true;

  users.users.shawn.home = /Users/shawn;

  # https://github.com/LnL7/nix-darwin/tree/master/modules/system/defaults
  system = {
    defaults.NSGlobalDomain = {
      AppleShowAllExtensions = true;
      AppleKeyboardUIMode = 3;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;
    };
    defaults.menuExtraClock = {
      Show24Hour = true;
      ShowDate = 0;
    };
    defaults.dock = {
      autohide = true;
      orientation = "right";
      wvous-br-corner = 4;
    };
    defaults.finder = {
      FXPreferredViewStyle = "Nlsv";
      ShowPathbar = true;
      ShowStatusBar = true;
    };
    defaults.spaces = {
      # By default (false) each display has its own space
      # Enable (true) to have one space across all displays
      spans-displays = true;
    };
  };
}
