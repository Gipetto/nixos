{
  description = "WookieeNix";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    tpm = {
      url = "github:tmux-plugins/tpm";
      flake = false;
    };
    private-fonts = {
      # Private flake for housing free & paid fonts.
      # Repo is always private to respect the paid font creators.
      url = "git+ssh://git@github.com/Gipetto/fonts";
      flake = true;
    };
    hyprkeys = {
      url = "github:Gipetto/hyprkeys";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    codex-package = {
      type = "tarball";
      url = "https://github.com/openai/codex/releases/download/rust-v0.145.0/codex-package-aarch64-apple-darwin.tar.gz";
      narHash = "sha256-g/WaulBylOtgCcIO/p9Cn+n27LCvFon39iKC0QRDxuY=";
      flake = false;
    };
    opencode.url = "github:anomalyco/opencode/v1.18.3";
  };

  outputs = {
    self,
    nixpkgs-unstable,
    nixos-hardware,
    home-manager,
    ...
  }@inputs:
    let
      # Helper to make pkgs with allowUnfree
      mkPkgs = { flake, system }: import flake {
        inherit system;
        config.allowUnfree = true;
      };
      mkDarwinUser = user: {
        home.username = user;
        home.homeDirectory = "/Users/${user}";
        home.stateVersion = "24.05";
      };
    in
    {
      nixosConfigurations = {
        nab5 = nixpkgs-unstable.lib.nixosSystem {
          system = "x86_64-linux";
          pkgs = mkPkgs {
            flake = nixpkgs-unstable;
            system = "x86_64-linux";
          };
          modules = [
            nixos-hardware.nixosModules.common-cpu-intel
            ./hosts/nab5
            ./common/autoupgrade.nix
            ./common/configuration.nix
            ./common/users.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs;
                };
                backupFileExtension = "bkp";
                users.shawn = import ./home-manager/nab5.nix;
              };
            }
          ];
        };

        tower = nixpkgs-unstable.lib.nixosSystem {
          system = "x86_64-linux";
          pkgs = mkPkgs {
            flake = nixpkgs-unstable;
            system = "x86_64-linux";
          };
          specialArgs = {
            inherit home-manager;
            inherit inputs;
          };
          modules = [
            nixos-hardware.nixosModules.common-cpu-amd
            ./hosts/tower
            ./common/configuration.nix
            ./common/users.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = {
                  inherit inputs;
                };
                backupFileExtension = "bkp";
                users.shawn = import ./home-manager/tower.nix;
              };
            }
          ];
        };
      };

      homeConfigurations = {
        "shawn@darwin" = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs {
            flake = nixpkgs-unstable;
            system = "aarch64-darwin";
          };
          modules = [
            ./home-manager/darwin.nix
            ./home-manager/wander.nix
            (mkDarwinUser "shawn")
          ];
          extraSpecialArgs = { inherit inputs; };
        };
      };

      # Dev shells for working on this config
      devShells = nixpkgs-unstable.lib.genAttrs [
        "x86_64-linux"
        "aarch64-darwin"
      ] (system:
        let pkgs = nixpkgs-unstable.legacyPackages.${system};
        in {
          default = pkgs.mkShell {
            packages = with pkgs; [
              nixpkgs-fmt
              nil  # nix LSP
            ];
          };
        }
      );

      apps = {
        aarch64-darwin.hm = {
          type = "app";
          program = "${home-manager.packages.aarch64-darwin.home-manager}/bin/home-manager";
        };
      };
    };
}
