{ pkgs }:
let
  theme = import ./. { inherit pkgs; };
in
pkgs.vscode-utils.buildVscodeExtension {
  pname = "birren-industrial";
  version = theme.version;
  src = theme.vscode;
  sourceRoot = theme.vscode.name;
  vscodeExtPublisher = "shawnp";
  vscodeExtName = "birren-industrial";
  vscodeExtUniqueId = "shawnp.birren-industrial";
}
