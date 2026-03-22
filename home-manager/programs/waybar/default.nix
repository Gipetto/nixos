{ ... }:
{
  programs.waybar = {
    enable = true;
  };
  xdg.configFile."waybar/config.jsonc".source = ./config.jsonc;
  xdg.configFile."waybar/style.css".source = ./style.css;
  xdg.configFile."waybar/power_menu.xml".source = ./power_menu.xml;
  xdg.configFile."waybar/temps.sh" = {
    source = ./temps.sh;
    executable = true;
  };
}
