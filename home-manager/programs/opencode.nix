# opencode ships a Bun-compiled single-file binary; macOS code-signing
# enforcement can reject its embedded ad-hoc signature and SIGKILL the exec,
# so re-sign ad-hoc at install time. The upstream package contains only the
# binary, so ripgrep is propagated explicitly.
{ pkgs }:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "opencode";
  version = "2.2.5";
  src = pkgs.fetchurl {
    url = "https://registry.npmjs.org/@opencode/cli-darwin-arm64/-/cli-darwin-arm64-${version}.tgz";
    hash = "sha256-39gn3jKBtMPKKwv8j0vrED+mYMQZ0UihpRXENE+enAI=";
  };
  sourceRoot = "package";
  propagatedBuildInputs = [ pkgs.ripgrep ];
  installPhase = ''
    runHook preInstall
    mkdir -p "$out/bin"
    cp bin/opencode "$out/bin/opencode"
    chmod +x "$out/bin/opencode"
    /usr/bin/codesign --force --sign - "$out/bin/opencode"
    runHook postInstall
  '';
}
