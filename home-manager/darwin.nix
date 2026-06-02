{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
    ./programs/fonts.nix
    ./programs/ghostty
    ./programs/vscode-birren-industrial.nix
  ];

  xdg.configFile."nix/nix.conf".text = ''
    cores = 10
  '';

  programs.vscode = {
    enable = true;
    package = null;
  };

  home.packages = with pkgs; [
    _1password-cli
    docker-client
    iterm2
    opencode
  ];

  targets.darwin = {
    copyApps.enable = true;
    linkApps.enable = false;
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.nix-profile/bin"
  ];

  home.sessionVariables = {
    _ZO_EXCLUDE_DIRS = "${config.home.homeDirectory};${config.home.homeDirectory}/Projects/Wander";
    UV_TOOL_DIR = "${config.home.homeDirectory}/.local/share/uv/tools";
  };

  # Prevent biome from testing on every derivation...
  nixpkgs.overlays = [
    (final: prev: {
      biome = prev.biome.overrideAttrs { doCheck = false; };
    })
  ];

}
