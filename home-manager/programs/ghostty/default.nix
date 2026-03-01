{ config, lib, pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "Berkeley Mono";
      font-variation = "wght=500";
      font-size = if pkgs.stdenv.isDarwin
        then 11.5
        else 10.5;
      font-feature = [ "liga=1" "calt=1" ];
      theme = "iTerm2 Solarized Light";
      auto-update-channel = "stable";
      mouse-hide-while-typing = true;
      scroll-to-bottom = "keystroke";
      window-padding-x = 12;
      window-padding-y = 12;
      window-step-resize = true;
      window-inherit-working-directory = false;
      working-directory = "home";
      quick-terminal-position = "center";
      quick-terminal-screen = "mouse";
      shell-integration-features = "ssh-env,no-cursor";
      cursor-style = "block";
      cursor-style-blink = false;
      macos-titlebar-style = "tabs";
      macos-titlebar-proxy-icon = "hidden";
      macos-option-as-alt = true;
      scrollback-limit = 16000000;
      selection-background = "#657b83";
      selection-foreground = "#fdf6e3";
      cursor-color = "#657b83";
      cursor-text = "#fdf6e3";
      palette = [ "7=#eee8d5" ];
      keybind = if pkgs.stdenv.isDarwin
        then "global:cmd+shift+grave_accent=toggle_quick_terminal"
        else "global:super+shift+grave_accent=toggle_quick_terminal";
      window-width = 125;
      window-height = 76;
      adjust-cell-height = "5%";
    };
  };
}
