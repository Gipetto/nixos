{ pkgs, ... }:
let
  birrenIndustrial = import ../../themes/birren-industrial { inherit pkgs; };
in
{
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then null else pkgs.ghostty;
    settings = {
      font-family = "Berkeley Mono";
      font-variation = "wght=500";
      font-size =
        if pkgs.stdenv.isDarwin
        then 13
        else 10.5;
      font-feature = [ "liga=1" "calt=1" ];
      theme = "birren-industrial-light";
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
      keybind =
        if pkgs.stdenv.isDarwin
        then "global:cmd+shift+`=toggle_quick_terminal"
        else "global:super+shift+grave_accent=toggle_quick_terminal";
      window-width = 125;
      window-height = 76;
      window-new-tab-position = "end";
      adjust-cell-height = "5%";
    };
  };

  xdg.configFile."ghostty/themes/birren-industrial-light".source = birrenIndustrial.ghostty.light;
}
