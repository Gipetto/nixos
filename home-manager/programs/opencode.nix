# opencode ships a Bun-compiled ("bun build --compile") single-file binary.
# script/build.ts runs a build-time smoke test that execs the freshly
# compiled binary before nix ever installs it. On Darwin 25+ (macOS 16),
# Bun's embedded ad-hoc signature is rejected by the kernel's code-signing
# enforcement, which SIGKILLs (exit 137) any exec of the binary -- so the
# smoke test itself crashes the whole nix build.
#
# Fix: re-sign with a fresh ad-hoc signature immediately after compile,
# before the smoke test runs. No-op on non-Darwin.
{ inputs, pkgs }:
let
  system = pkgs.stdenv.hostPlatform.system;
  base = inputs.opencode.packages.${system}.opencode;
in
if pkgs.stdenv.hostPlatform.isDarwin then
  base.overrideAttrs (old: {
    postPatch = (old.postPatch or "") + ''
      substituteInPlace packages/opencode/script/build.ts \
        --replace-fail \
          '  // Smoke test: only run if binary is for current platform' \
          '  if (item.os === "darwin") {
    await $`/usr/bin/codesign --force --sign - dist/''${name}/bin/opencode`
  }

  // Smoke test: only run if binary is for current platform'
    '';
  })
else
  base
