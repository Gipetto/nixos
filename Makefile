PLATFORM := $(shell uname -s)
HOSTNAME := $(shell hostname)

# List of hosts that run full NixOS (not just Home Manager)
NIXOS_HOSTS := nab5

NIX_DAEMON := /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
NIX_SH := /nix/var/nix/profiles/default/etc/profile.d/nix.sh

# --- INIT: first-time system activation (NixOS or Darwin only) ---
.PHONY: init
init:
ifeq ($(PLATFORM),Darwin)
	xcode-select --install || true
	sudo cp /etc/zshrc /etc/zshrc.pre-nix-install || true
	sudo cp /etc/zprofile /etc/zprofile.pre-nix-install || true
	curl -fsSL https://install.determinate.systems/nix | sh -s -- install || true
	mkdir -p ~/.config/nix
	/nix/var/nix/profiles/default/bin/nix \
		--extra-experimental-features "nix-command flakes" \
		build .#darwinConfigurations.darwinDefault.system --out-link ./darwin-system && \
		./darwin-system/sw/bin/darwin-rebuild switch --flake .#darwinDefault
else ifeq ($(PLATFORM),Linux)
ifneq ($(filter $(HOSTNAME),$(NIXOS_HOSTS)),)
	sudo nixos-rebuild build --flake .
	sudo nixos-rebuild test --flake .
	sudo nixos-rebuild switch --flake .#nixosConfigurations.$(HOSTNAME)
else
# Chicken and egg problem: we need home-manager to install
# but we can't install it because later it'll conflict with 
# home-manager that's managed via the flake
	NIXPKGS_ALLOW_UNFREE=1 nix shell nixpkgs#home-manager -c \
		home-manager switch --flake .#$(HOSTNAME) --impure -b backup
endif
else
	$(error Unsupported platform: $(PLATFORM))
endif

# --- REBUILD: idempotent config sync (works everywhere) ---
.PHONY: rebuild
rebuild:
ifeq ($(PLATFORM),Darwin)
	darwin-rebuild switch --flake .#darwinDefault
else ifeq ($(PLATFORM),Linux)
ifneq ($(filter $(HOSTNAME),$(NIXOS_HOSTS)),)
	sudo nixos-rebuild switch --flake .#nixosConfigurations.$(HOSTNAME)
else
	NIXPKGS_ALLOW_UNFREE=1 home-manager switch --flake .#$(HOSTNAME) --impure -b backup
endif
else
	$(error Unsupported platform: $(PLATFORM))
endif

# .PHONY: install-vscode-debian
# install-vscode-debian:
# 	@echo "Adding VS Code repository..."
# 	@curl -fsSL https://code.visualstudio.com/keys/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/packages.microsoft.gpg > /dev/null
# 	@echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
# 	@sudo apt update -qq
# 	@sudo apt install -y code
# 	@echo "✓ VS Code installed via system package manager (auto-updates enabled)"
