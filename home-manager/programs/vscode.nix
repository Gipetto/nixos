{ config, pkgs, lib, inputs,  ... }:
let
  fontSize = if pkgs.stdenv.isDarwin then 13 else 14;
  vscode-extensions = inputs.nix-vscode-extensions
    .extensions.${pkgs.stdenv.hostPlatform.system}.vscode-marketplace;
in
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      # User settings are handled via VSCode Profile Sync
      extensions = [
        vscode-extensions.denoland.vscode-deno
        vscode-extensions.docker.docker
        vscode-extensions.eamodio.gitlens
        vscode-extensions.ms-python.autopep8
        vscode-extensions.ms-python.black-formatter
        vscode-extensions.ms-python.debugpy
        vscode-extensions.ms-python.python
        vscode-extensions.ms-vscode.makefile-tools
        vscode-extensions.svelte.svelte-vscode
        # Unfree extensions - can install manually if needed
        #vscode-extensions.ms-vscode-remote.remote-containers
        #vscode-extensions.ms-vscode-remote.remote-ssh
        #vscode-extensions.ms-vscode-remote.remote-ssh-edit
        #vscode-extensions.ms-vscode.remote-explorer
      ];
    };
  };
}
