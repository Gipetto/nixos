.PHONY: help init update rebuild rebuild-nix rebuild-chezmoi sync check clean

PLATFORM := $(shell uname -s)
HOSTNAME := $(shell hostname -s)
USER := $(shell whoami)

# List of hosts that run full NixOS (not just Home Manager)
NIXOS_HOSTS := nab5 tower

# Default target
help:
	@echo "Available targets:"
	@echo "  init              - Initialize chezmoi on a new machine"
	@echo "  update            - Update flake inputs"
	@echo "  rebuild           - Rebuild both nix and chezmoi"
	@echo "  rebuild-nix       - Only rebuild nix configuration"
	@echo "  rebuild-chezmoi   - Only apply chezmoi dotfiles"
	@echo "  sync              - Update and rebuild everything"
	@echo "  check             - Check flake validity"
	@echo "  clean             - Clean up old generations"

# Initialize chezmoi on a new machine
init:
	@echo "Initializing chezmoi..."
	@chezmoi init --source $(PWD)/chezmoi https://github.com/Gipetto/nixos.git
	
# Update flake inputs
update:
	nix flake update

# Rebuild based on platform and hostname
rebuild-nix:
ifeq ($(PLATFORM),Darwin)
	@echo "Rebuilding home-manager (darwin)..."
	home-manager switch --flake .#"$(USER)@darwin"
else ifeq ($(PLATFORM),Linux)
ifneq ($(filter $(HOSTNAME),$(NIXOS_HOSTS)),)
	@echo "Rebuilding NixOS system ($(HOSTNAME))..."
	sudo nixos-rebuild switch --flake .#$(HOSTNAME)
else
	@echo "Unknown Linux host: $(HOSTNAME)"
	@echo "Add $(HOSTNAME) to NIXOS_HOSTS in Makefile or create homeConfiguration"
	@exit 1
endif
else
	@echo "Unsupported platform: $(PLATFORM)"
	@exit 1
endif

# Apply chezmoi dotfiles
rebuild-chezmoi:
	@echo "Applying chezmoi dotfiles..."
	@chezmoi apply

# Rebuild both
rebuild: rebuild-nix rebuild-chezmoi

# Full sync
sync: update rebuild

# Check flake validity
check:
	nix flake check

# Garbage collection
clean:
	@echo "Cleaning old generations..."
ifneq ($(filter $(HOSTNAME),$(NIXOS_HOSTS)),)
	sudo nix-collect-garbage -d
else
	nix-collect-garbage -d
endif
	@echo "Optimizing nix store..."
	nix-store --optimise
