# Nix configuration assistance

This repository is a personal Nix configuration. Keep changes small and
specific to the requested update.

## Routine updates

- Do not use Git worktrees for this repository.
- For minor configuration and package-pin updates, work directly in this main
  checkout on the `main` branch. Do not create a feature branch unless asked.
- Preserve unrelated uncommitted changes. Inspect the diff for only the files
  needed by the request.
- For a pinned binary release, update its version and fixed-output hash
  together. Obtain the hash from the exact release asset.
- Validate Darwin Home Manager changes with:

  ```sh
  nix build '.#homeConfigurations."shawn@darwin".activationPackage' --no-link
  ```

- Do not apply a system rebuild unless the user asks for it.

## Scope and verification

- Do not update flake inputs, reformat unrelated files, or add dependencies
  unless the requested change requires it.
- Report the files changed, the validation command, and any existing changes
  left untouched.
