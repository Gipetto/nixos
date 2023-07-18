.PHONY: init-darwin

NIX_DAEMON = /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
NIX_SH = /nix/var/nix/profiles/default/etc/profile.d/nix.sh

init-nixos:
	# Build then test to ensure we can easily recover if something fails
	sudo nixos-rebuild build --flake .
	sudo nixos-rebuild test --flake .
	sudo nixos-rebuild switch --flake .

init-darwin:
	xcode-select --install || true # Though you probably don't have `make` without this
	curl -L https://nixos.org/nix/install | sh -s -- --daemon --yes
	mkdir -p ~/.config/nix
	echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

install-darwin:
	. $(NIX_DAEMON); . $(NIX_SH); \
	  nix build .#darwinDefault; \
	  ./result/sw/bin/darwin-rebuild switch --flake .#darwinDefault

rebuild-darwin:
	darwin-rebuild switch --flake .#darwinDefault

darwin-reset:
	sudo mv -v /etc/bashrc.backup-before-nix /etc/bashrc; \
	  sudo mv -v /etc/zshrc.backup-before-nix /etc/bashrc;
