.PHONY: preview-update preview-check

THEME_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
REPO_ROOT := $(abspath $(THEME_DIR)/../../..)
PREVIEW := $(THEME_DIR)/palette.svg
PREVIEW_EXPR := let inputs = (builtins.getFlake "$(REPO_ROOT)").inputs; pkgs = import inputs.nixpkgs-unstable { system = builtins.currentSystem; }; in (import "$(THEME_DIR)" { inherit pkgs; }).preview.svg

preview-update:
	@set -eu; \
		rendered="$$(nix build --impure --no-link --print-out-paths --expr '$(PREVIEW_EXPR)')"; \
		install -m 0644 "$$rendered" "$(PREVIEW).tmp"; \
		mv -f "$(PREVIEW).tmp" "$(PREVIEW)"; \
		echo "Updated $(PREVIEW)"

preview-check:
	@set -eu; \
		rendered="$$(nix build --impure --no-link --print-out-paths --expr '$(PREVIEW_EXPR)')"; \
		if ! cmp -s "$(PREVIEW)" "$$rendered"; then \
			echo "palette.svg is stale; run 'make preview-update' in $(THEME_DIR)." >&2; \
			exit 1; \
		fi
