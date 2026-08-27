# WookieeNix

## Install

Install nix (if not NixOS or nix already installed) and check out this repo in to ~/Projects.

Specifically not bootstrapping the host in the install script to make this a process that's friendly to bootstrapping new hosts.

```sh
curl -fsSL https://raw.githubusercontent.com/gipetto/nixos/main/install.sh | bash
```

### Post-install: NixOS

To restore a new NixOS host:

```sh
sudo cp /etc/nixos /etc/nixos-orig
git clone git@github.com:Gipetto/nixos.git ~/Projects/nixos
cd ~/Projects/nixos
```

If this is a new host:
- create host specific files in the `hosts` directory
- update `flake.nix` to reflect necessary changes

```sh
make rebuild
```

**Open Question:** what is the best way to do hardware configuration in the 
new flake world?

### Post-install: Linux (Non-NixOS)

```sh
cd ~/Projects/nixos
make rebuild
```

### Post-install: MacOS

```sh
cd ~/Projects/nixos
make rebuild
```

## Notes

### Zsh

- Local ad-hoc configuration can be done by adding a `~/.zshrc.local` file

### Git

- Home Manager writes the managed configuration to `~/.config/git/config`
- Global Git ignores are read from `~/.config/git/ignore`
- Add local overrides to `~/.config/git/config-local`

### Docs

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager](https://nix-community.github.io/home-manager/index.html#ch-nix-flakes)
- [Nix Darwin](http://daiderd.com/nix-darwin/)

# Cheat Sheet

Find details on Packages, NixOS options and Flakes: 
[https://search.nixos.org](https://search.nixos.org)


## Nix Commands

| Operation | Command |
| --------- | ------- |
| Search | `nix search nixpkgs -t name 'package'` |
| Update flake inputs | `nix flake update` |
| Apply config (NixOS) | `sudo nixos-rebuild switch --flake .#nab5` |
| Apply config (Darwin) | `make rebuild` |
| Apply config (Linux HM) | `nix run .#homeConfigurations.tower` |

**A full upgrade cycle consists of:**
- Update flake inputs
- Apply config

## Nix-Shell

| Operation | Command |
| --------- | ------- |
| New shell with packages | `nix-shell -p pandoc` |

## Garbage Collection & Pruning

| Operation | Command |
| --------- | ------- |
| Remove all generations | `nix-env --delete-generations old` |
| Remove specific generations | `nix-env --delete-generations 10 11 14` |
| Remove generations by age | `nix-env --delete-generations 14d` |
| Garbage collect | `nix-store --gc` |
| Remove old & garbage collect | `nix-collect-garbage -d` |

## Show installed packages
| Operation | Command |
| --------- | ------- |
| List packages in current environment | `nix-env -q` |
| List packages in current system & current environment | `nix-store -q --requisites /run/current-system ~/.nix-profile` |
| List direct dependencies of the current system | `nix-store -q --references /run/current-system` |

# Discover package configuration options

```sh
$ nix repl
```

Then

``` sh
:lf .
homeConfigurations."shawn@darwin".options.programs.zsh
```

## Mounting Drives (NixOS)

To permanently mount a drive, update `hosts/<host>/default.nix`. Keep hardware-specific mount definitions in `hosts/<host>/hardware-configuration.nix` when appropriate.


## Test in VM

```sh
nixos-rebuild build-vm --flake .#nab5
./result/bin/run-nab5-vm
```

[More Info on VMs](https://nixos.org/manual/nixos/stable/)


## Uninstall (Mac, non-NixOS Linux)

[Uninstalling Nix (Determinate)](https://docs.determinate.systems/nix/installation/uninstalling)

``` sh
curl -fsSL https://install.determinate.systems/nix/uninstall > uninstall.sh
less uninstall.sh  # review
sh uninstall.sh
```
