{
  description = "WookieeNix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgsDarwin.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
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
  {
    nixosConfigurations = {
      # nab5 === full NixOS install
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
          {
            nixpkgs.config.allowUnfree = true;
          }
        ];
      };
    };

    darwinConfigurations = {
      # Generic MacOS config
      darwinDefault = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/darwin.nix
          ./common/configuration.nix
          ./common/fonts.nix
          home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.shawn = import ./home-manager/shawn.nix;
          }
          {
            nixpkgs.config.allowUnfree = true;
          }
        ];
      };
    };

    homeConfigurations = {
      # tower == generic linux
      tower = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [
          ./hosts/tower
          ./home-manager/fonts.nix
          ./home-manager/shawn.nix
        ];
      };
    };
  };
}
