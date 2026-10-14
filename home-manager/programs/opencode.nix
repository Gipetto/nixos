# opencode ships a Bun-compiled single-file binary; macOS code-signing
# enforcement can reject its embedded ad-hoc signature and SIGKILL the exec,
# so re-sign ad-hoc at install time. The upstream zip contains only the
# binary, so ripgrep is propagated explicitly.
{ pkgs }:

pkgs.stdenvNoCC.mkDerivation rec {
  pname = "opencode";
  version = "1.19.0";
  src = pkgs.fetchurl {
    url = "https://github.com/anomalyco/opencode/releases/download/v${version}/opencode-darwin-arm64.zip";
    hash = "sha256-DV9RGUjW+/7fm7FnU8CsQmE9zI3nXZ3rfo0M9YTI+6Y=";
  };
  sourceRoot = ".";
  nativeBuildInputs = [ pkgs.unzip ];
  propagatedBuildInputs = [ pkgs.ripgrep ];
  installPhase = ''
    runHook preInstall
    mkdir -p "$out/bin"
    cp opencode "$out/bin/opencode"
    chmod +x "$out/bin/opencode"
    /usr/bin/codesign --force --sign - "$out/bin/opencode"
    runHook postInstall
  '';
}
