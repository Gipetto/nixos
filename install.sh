#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/gipetto/nixos"
PROJECTS_DIR="$HOME/Projects"
FLAKE_DIR="$PROJECTS_DIR/nixos"

# Detect platform
PLATFORM="$(uname -s)"
HOSTNAME="$(hostname)"

# --- STEP 1: Install Nix (if needed) ---
if command -v nix &>/dev/null; then
  echo "→ Nix already installed"
else
  if [ "$PLATFORM" = "Linux" ]; then
    # Skip on actual NixOS (nix is already present)
    if [ -e /etc/NIXOS ]; then
      echo "→ Running on NixOS—skipping Nix install"
    else
      echo "→ Installing Nix (Determinate) on Linux..."
      curl -fsSL https://install.determinate.systems/nix | sh -s -- install
      . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
    fi
  elif [ "$PLATFORM" = "Darwin" ]; then
    echo "→ Installing Nix (Determinate) on macOS..."
    curl -fsSL https://install.determinate.systems/nix | sh -s -- install
    . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
  else
    echo "Unsupported platform: $PLATFORM" >&2
    exit 1
  fi
fi

# --- STEP 2: Install git via Nix ---
echo "→ Installing git via Nix..."
nix shell nixpkgs#git -c true  # ensures git is available in this session

# --- STEP 3: Clone config repo ---
mkdir -p "$PROJECTS_DIR"
if [ ! -d "$FLAKE_DIR" ]; then
  echo "→ Cloning config repo to $FLAKE_DIR"
  nix shell nixpkgs#git -c git clone "$REPO_URL" "$FLAKE_DIR"
else
  echo "→ Config repo already exists at $FLAKE_DIR"
fi

# --- STEP 4: Instructions for new hosts ---
cat <<EOF

✅ Bootstrapping complete!

Next steps:
1. If this is a NEW host, add its configuration to the flake:
   - Linux non-NixOS (e.g., Pop!_OS): add to homeConfigurations.<hostname>
   - NixOS machine: add to nixosConfigurations and NIXOS_HOSTS in Makefile
2. Then run:
      make -C "$FLAKE_DIR" init      # only for NixOS/macOS first-time setup
   or
      make -C "$FLAKE_DIR" rebuild   # for non-NixOS Linux or subsequent updates

EOF