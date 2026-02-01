{
  description = "WookieeNix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    nixpkgsDarwin.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgsDarwin";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = inputs@{
    self,
    nixpkgs,
    nixpkgs-unstable,
    nixpkgsDarwin,
    nix,
    nixos-hardware,
    home-manager,
    nix-darwin,
    nix-vscode-extensions,
  }:
  let
    mkPkgs = { flake, system }: import flake {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in
  {
    # Full NixOS Installs
    nixosConfigurations = {
      nab5 = nixpkgs.lib.nixosSystem {
        pkgs = mkPkgs { 
          flake = nixpkgs; 
          system = "x86_64-linux"; 
        };
        specialArgs = {
          inherit inputs home-manager;
          unstable = mkPkgs { 
            flake = nixpkgs-unstable; 
            system="x86_64-linux"; 
          };
        };
        modules = [
          nixos-hardware.nixosModules.common-cpu-intel
          ./hosts/nab5
          ./common/configuration.nix
          ./common/users.nix
          ./common/autoupgrade.nix
          home-manager.nixosModules.home-manager {
            home-manager.pkgs = mkPkgs { 
              flake = nixpkgs; 
              system = "x86_64-linux"; 
            };
            home-manager.extraSpecialArgs = {
              inherit inputs;
              unstable = mkPkgs { 
                flake = nixpkgs-unstable; 
                system="x86_64-linux"; 
              };
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.shawn = import ./home-manager/shawn.nix;
          }
        ];
      };
      tower = nixpkgs.lib.nixosSystem {
        #pkgs = mkPkgs { 
        #  flake = nixpkgs; 
        #  system = "x86_64-linux";
        #};
        specialArgs = {
          inherit inputs;
        #  unstable = mkPkgs { 
        #    flake = nixpkgs-unstable; 
        #    system="x86_64-linux";
        #  };
        };
        modules = [
          nixos-hardware.nixosModules.common-cpu-amd
          ./hosts/tower
          ./common/users.nix
          ./common/autoupgrade.nix
          home-manager.nixosModules.home-manager {
#             home-manager.pkgs = mkPkgs { 
#               flake = nixpkgs; 
#               system = "x86_64-linux";
#             };
#             home-manager.extraSpecialArgs = {
#               inherit inputs;
#               unstable = mkPkgs { 
#                 flake = nixpkgs-unstable; 
#                 system="x86_64-linux";
#               };
#             }; 
	    home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.shawn = import ./home-manager/shawn.nix;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = {
              inherit inputs;
            };
          }
        ];
      };
    };

    darwinConfigurations = {
      # Generic MacOS config
      darwinDefault = nix-darwin.lib.darwinSystem {
       	pkgs = mkPkgs { 
          flake = nixpkgs; 
          system = "aarch64-linux";
        };
        specialArgs = {
          inherit inputs;
          unstable = mkPkgs { 
            flake = nixpkgs-unstable; 
            system="aarch64-linux"; 
          };
        };
        modules = [
          ./hosts/darwin.nix
          ./common/configuration.nix
          ./common/fonts.nix
          home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.shawn = import ./home-manager/shawn.nix;
          }
        ];
      };
    };

#    homeConfigurations = {
#       # tower == generic linux
#       tower = home-manager.lib.homeManagerConfiguration {
#         pkgs = nixpkgs.legacyPackages.x86_64-linux;
#         extraSpecialArgs = { inherit inputs; };
#         modules = [
#           ./hosts/tower
#           ./home-manager/fonts.nix
#           ./home-manager/shawn.nix
#         ];
#       };
#     };
  };
}
