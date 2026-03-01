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
      userSettings = {
        "accessibility.dimUnfocused.enabled" = true;
        "accessibility.dimUnfocused.opacity" = 0.8;
        "debug.javascript.autoAttachFilter" = "disabled";
        "debug.javascript.automaticallyTunnelRemoteServer" = false;
        "chat.agent.enabled" = false;
        "chat.commandCenter.enabled" = false;
        "editor.fontFamily" = "'Berkeley Mono', 'Monaspace Neon Var', 'Menlo', Monaco, 'Courier New', monospace";
        "editor.fontLigatures" = "'ss01', 'ss02', 'ss03', 'ss04', 'ss05', 'ss06', 'ss07', 'ss08', 'calt', 'dlig'";
        "editor.fontSize" = fontSize;
        "editor.fontVariations" = true;
        "editor.formatOnSave" = true;
        "editor.inlayHints.enabled" = "off";
        "editor.minimap.enabled" = false;
        "editor.tabSize" = 2;
        "files.insertFinalNewline" = true;
        "svelte.plugin.svelte.defaultScriptLanguage" = "ts";
        "svg.preview.mode" = "svg";
        "terminal.integrated.fontSize" = fontSize;
        "workbench.colorTheme" = "Default Light+";
      };
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
