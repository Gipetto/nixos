{ pkgs, ... }: {
  home.packages = [
    pkgs.nerd-fonts.hasklug
  ];

  # Optional: enable user fontconfig
  fonts.fontconfig.enable = true;
}