.PHONY: init-darwin

PLATFORM := $(shell uname -s)

NIX_DAEMON := /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
NIX_SH := /nix/var/nix/profiles/default/etc/profile.d/nix.sh

init:
ifeq ("$(PLATFORM)","Darwin")
	xcode-select --install || true # Though you probably don't have `make` without this
	curl -L https://nixos.org/nix/install | sh -s -- --daemon --yes
	mkdir -p ~/.config/nix
	echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
else
	# Build then test to ensure we can easily recover if something fails
	sudo nixos-rebuild build --flake .
	sudo nixos-rebuild test --flake .
endif

install:
ifeq ("$(PLATFORM)","Darwin")
	. $(NIX_DAEMON); . $(NIX_SH); \
	  nix build .#darwinDefault; \
	  ./result/sw/bin/darwin-rebuild switch --flake .#darwinDefault
else
	sudo nixos-rebuild switch --flake .
endif

rebuild:
ifeq ("$(PLATFORM)","Darwin")
	darwin-rebuild switch --flake .#darwinDefault
else
	nixos-rebuild switch
endif

