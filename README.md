# WookieeNix

## Install

Install process is currently dumb basic:

- Install NixOS
- Check out this repo to `/etc/nixos`
- Run `sudo nixos-rebuild switch`

## Zsh

- Local ad-hoc configuration can be done by adding a `~/.zshrc.local` file

## Git

- The included `config/gitconfig` is registered as an include in `/etc/gitconfig`
- The included `config/gitignore` is registered as a global exludes file in `/etc/gitconfig`
- The declarations in home manager are supplied in `~/.config/git/gitconfig`
- Local overrides can still be made by adding and populating a `~/.gitconfig` file

## Docs

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager](https://nix-community.github.io/home-manager/index.html#ch-nix-flakes)
- [Nix Darwin](http://daiderd.com/nix-darwin/)

# Cheat Sheet

Find details on Packages, NixOS options and Flakes: 
[https://search.nixos.org](https://search.nixos.org)

## Nix-Env (pre nix-commands)

| Operation | Command |
| --------- | ------- |
| Search | `nix-env -qaP '.*package.*'` |
| Install | `nix-env -i package-name` |
| Upgrade | `nix-channel --update nixpkgs`<br>`nix-env --upgrade '*'` |
| Uninstall | `nix-env --uninstall package-name` |
| Rollback | `nix-env --rollback` |
| Info (short) | `nix-env -qaP --description '.*package.*'` |
| Info (full) | `nix-env -qaP --description --json --meta '.*package.*'` |
| List packages in the current environment<br>(non-system packages) | `nix-env -qa --installed "*"` |

## Nix-Shell

| Operation | Command |
| --------- | ------- |
| New shell with packages | `nix-shell -p pandoc` |

## Garbage Collection & Pruning

| Operation | Command |
| --------- | ------- |
| Remove all generations | `nix-env --delete-generations old` |
| Remove specific generations | `nix-env --delete-generations 10 11 14` |
| Remove generagions by age | `nix-env --delete-generations 14d` |
| Garbage collect | `nix-store --gc` |
| Remove old & garbage collect | `nix-collect-garbage -d` |

## Systemctl

Not NixOS specific.

| Operation | Command |
| --------- | ------- |
| List running services | `systemctl --type=service --state=running` |
| Show timers | `systemctl list-timers` |

## Mounting Drives

To permanently mount a drive, rebuild the hardware-configuration after the drive has been mounted. You many need to prune out Docker overlays before applying with `nixos-rebuild`.

``` sh
$ nixos-regenerate-config
$ nixos-rebuild switch
```

## Test in VM

```sh
nixos-rebuild build-vm --flake https://github.com/Gipetto/nixos/tarball/master
./result/bin/run-nixos-vm
```

[More Info on VMs](https://nixos.org/manual/nixos/stable/)

