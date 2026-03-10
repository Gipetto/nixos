{ config, pkgs, lib, ... }:

{
  imports = [
    ./common.nix
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
  ];

  # ensure that pathing is correct when loading login shells in vscode
  home.activation.zprofileNixPath = lib.hm.dag.entryAfter ["writeBoundary"] ''
    if ! grep -q 'nix-profile/bin' "$HOME/.zprofile" 2>/dev/null; then
      echo 'path=("$HOME/.nix-profile/bin" $path)' >> "$HOME/.zprofile"
    fi
  '';
}
