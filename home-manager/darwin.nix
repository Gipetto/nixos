{ config, pkgs, lib, ... }:

{
  imports = [
    ./common.nix
    ./programs/fonts.nix
  ];

  nix = {
    package = pkgs.nix;
    settings = {
      max-jobs = "auto";
      cores = 10;
    };
  };

  home.packages = with pkgs; [
    _1password-cli
    docker-client
    iterm2
    opencode
  ];

  # ensure that pathing is correct when loading login shells in vscode
  home.activation.zprofileNixPath = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if ! grep -q 'nix-profile/bin' "$HOME/.zprofile" 2>/dev/null; then
      echo 'path=("$HOME/.nix-profile/bin" $path)' >> "$HOME/.zprofile"
    fi
  '';

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
