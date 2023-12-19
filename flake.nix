{
  description = "WookieeNix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgsDarwin.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgsDarwin";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgsDarwin,
    nix,
    nixos-hardware,
    home-manager,
    darwin
  }:
  {
    nixosConfigurations = {
      nab5 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          nixos-hardware.nixosModules.common-cpu-intel
          ./hosts/nab5
          ./common/configuration.nix
          ./common/users.nix
          ./common/autoupgrade.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.shawn = import ./home-manager/shawn.nix;
          }
        ];
      };
    };

    darwinConfigurations = {
      darwinDefault = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
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
  };
}
