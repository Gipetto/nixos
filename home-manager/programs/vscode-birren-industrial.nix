{ pkgs, ... }:
let
  birren-industrial = pkgs.vscode-utils.buildVscodeExtension {
    pname = "birren-industrial";
    version = "1.0.0";
    src = ../themes/birren-industrial/vscode;
    sourceRoot = ".";
    vscodeExtPublisher = "shawnp";
    vscodeExtName = "birren-industrial";
    vscodeExtUniqueId = "shawnp.birren-industrial";
  };
in
{
  programs.vscode.profiles.default.extensions = [
    birren-industrial
  ];
}
