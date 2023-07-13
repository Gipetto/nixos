.PHONY: init-darwin

GITHUB_URL = https://github.com/Gipetto/nixos

init-nixos:
	# Build then test to ensure we can easily recover if something fails
	sudo nixos-rebuild build --flake $(GITHUB_URL)
	sudo nixos-rebuild test --flake $(GITHUB_URL)
	sudo nixos-rebuild switch --flake $(GITHUB_URL)

init-darwin:
	# Nix
	sh <(curl -L https://nixos.org/nix/install)
	mkdir -p ~/.config/nix
	echo "experimental-features = nix-command flakes" >> ~/.config/nix.conf
	
	# Initial Build (verify this!)
	nix-env -iA nixpkgs.git
	git clone $(GITHUB_URL) ~/.nixos
	cd ~/.nixos
	nix build .#darwinConfigurations.<host>.system
	./result/sw/bin/darwin-rebuild switch --flake .#<host>

rebuild-darwin:
	darwin-rebuild switch --flake .#<host>

