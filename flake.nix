{
  description = "WookieeNix";

  inputs = {
    # Stable for NixOS server (nab5)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    
    # Unstable for workstation (tower) and macOS home-manager (darwin)
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Hardware modules for NixOS
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    
    # Home-manager follows unstable
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, ... }: 
    let
      # Helper to make pkgs with allowUnfree
      mkPkgs = { flake, system }: import flake {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      # NixOS configurations
      nixosConfigurations = {
        # Server - stable channel
        nab5 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          pkgs = mkPkgs { flake = nixpkgs; system = "x86_64-linux"; };
          specialArgs = {
            # Make unstable available for specific packages if needed
            unstable = mkPkgs { flake = nixpkgs-unstable; system = "x86_64-linux"; };
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
                users.shawn = import ./home-manager/nab5.nix;
                extraSpecialArgs = {
                  unstable = mkPkgs { flake = nixpkgs-unstable; system = "x86_64-linux"; };
                };
              };
            }
          ];
        };

        # Workstation - unstable channel
        tower = nixpkgs-unstable.lib.nixosSystem {
          system = "x86_64-linux";
          pkgs = mkPkgs { flake = nixpkgs-unstable; system = "x86_64-linux"; };
          specialArgs = {
            inherit home-manager;
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
                users.shawn = import ./home-manager/tower.nix;
              };
            }
          ];
        };
      };

      # Standalone home-manager for macOS
      homeConfigurations = {
        "shawn@darwin" = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs { flake = nixpkgs-unstable; system = "aarch64-darwin"; }; # or x86_64-darwin
          modules = [
            ./home-manager/darwin.nix
            {
              home = {
                username = "shawn";
                homeDirectory = "/Users/shawn";
                stateVersion = "24.05";
              };
            }
          ];
        };
      };

      # Dev shells for working on this config
      devShells = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ] (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in pkgs.mkShell {
          packages = with pkgs; [
            nixpkgs-fmt
            nil  # nix LSP
            chezmoi
          ];
        }
      );
    };
}
