{ pkgs, lib, config, ... }:
{
  # wallpaper generated with:
  # nix-shell -p imagemagick.out --run 'convert -size 3440x720 gradient:"#606060-#000000" \( -clone 0 -flip \) -append home-manager/programs/hyprpaper/gradient.png'

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${./gradient.png}" ];
      wallpaper = [
        {
          monitor = "DP-2";
          path = "${./gradient.png}";
          fit_mode = "cover";
        }
      ];
    };
  };
}
