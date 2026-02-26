#!/usr/bin/env bash
set -euo pipefail

echo ""
echo "brew prefix: $(brew --prefix)"
echo ""
echo "== Homebrew bin/sbin commands shadowed by something else in PATH =="
for pkg in $(brew list --formula); do
  bin="/opt/homebrew/bin/$pkg"
  if [ -x "$bin" ]; then
    resolved=$(command -v "$pkg" 2>/dev/null || true)
    if [ "$resolved" != "$bin" ] && [ -n "$resolved" ]; then
      echo "$pkg -> brew: $bin | active: $resolved"
    fi
  fi
done

echo ""
echo "== Homebrew installed Casks =="
brew list --cask
echo ""
