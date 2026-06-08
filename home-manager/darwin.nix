{ config, pkgs, lib, ... }:
let
  birrenIndustrial = import ./themes/birren-industrial/vscode-extension.nix { inherit pkgs; };
  cursorBirrenIndustrial = "shawnp.birren-industrial-${birrenIndustrial.version}";
in
{
  imports = [
    ./common.nix
    ./programs/fonts.nix
    ./programs/ghostty
  ];

  xdg.configFile."nix/nix.conf".text = ''
    cores = 10
  '';

  home.activation.cursorBirrenIndustrialTheme = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    cursorExtensionsDir="${config.home.homeDirectory}/.cursor/extensions"
    if [ -d "$cursorExtensionsDir" ]; then
      ln -sfn "${birrenIndustrial}/share/vscode/extensions/shawnp.birren-industrial" "$cursorExtensionsDir/${cursorBirrenIndustrial}"
    fi
  '';

  programs.vscode = {
    enable = true;
    package = null;
    profiles.default.extensions = [
      birrenIndustrial
    ];
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
