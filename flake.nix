{
  description = "WookieeNix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = { 
    self, 
    nixpkgs, 
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
    in
    {
      nixosConfigurations = {
        # Server - stable channel
        nab5 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          pkgs = mkPkgs { 
            flake = nixpkgs; 
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
                backupFileExtension = "bkp";
                users.shawn = import ./home-manager/nab5.nix;
              };
            }
          ];
        };

        # Workstation - unstable channel
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
                  # necessary to provide inputs to home-manager for vscode extensions
                  inherit inputs; 
                };
                users.shawn = import ./home-manager/tower.nix;
                backupFileExtension = "bkp";
              };
            }
          ];
        };
      };

      # Standalone home-manager for macOS
      homeConfigurations = {
        darwin = home-manager.lib.homeManagerConfiguration {
          pkgs = mkPkgs { 
            flake = nixpkgs-unstable; 
            system = "aarch64-darwin"; 
          };
          modules = [
            ./home-manager/darwin.nix
            {
              home = {
                username = builtins.getEnv "USER";
                homeDirectory = builtins.getEnv "HOME";
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
          ];
        }
      );
    };
}
