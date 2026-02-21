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
   - macOS: already configured as homeConfigurations.shawn@darwin
   - NixOS machine: add to nixosConfigurations (nab5 and tower already configured)

2. Apply the configuration:
   On NixOS (nab5, tower):
     cd $FLAKE_DIR
     sudo nixos-rebuild switch --flake .#\$(hostname -s)
   
   On macOS (darwin):
     cd $FLAKE_DIR
     home-manager switch --flake .#"shawn@darwin"

3. Initialize chezmoi for dotfiles:
     cd $FLAKE_DIR
     chezmoi init --source $FLAKE_DIR/chezmoi --apply $REPO_URL

4. Or use the Makefile shortcuts:
     make -C "$FLAKE_DIR" rebuild      # Applies nix config
     make -C "$FLAKE_DIR" rebuild-chezmoi  # Applies dotfiles
     make -C "$FLAKE_DIR" sync         # Does everything

EOF
