{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-templates.url = "github:lirelum/nix-templates";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-darwin, nixpkgs-unstable
    , home-manager, flake-utils, ... }:
    let
      inherit (self) outputs;
      inherit (flake-utils.lib) eachDefaultSystem;
    in eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {
        formatter = pkgs.nixfmt-classic;
        packages = import ./pkgs { inherit pkgs; };
      }) // {

        overlays.default = (final: prev: {
          local = outputs.packages.${final.system};
          unstable = import nixpkgs-unstable {
            system = final.system;
            config.allowUnfree = true;
          };
        });

        homeConfigurations."lirelum@zundamon" =
          home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.aarch64-darwin;
            extraSpecialArgs = { inherit inputs outputs; };
            modules = [
              ./home
              ./home-darwin
              {
                _module.args = rec {
                  username = "lirelum";
                  homeDirectory = "/Users/${username}";
                };
              }
            ];
          };

        homeConfigurations."autumn@miku" =
          home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = rec {
              inherit inputs outputs;
              username = "autumn";
              homeDirectory = "/home/${username}";
            };
            modules = [
              ./home
              ./home-nixos
              {
                _module.args = rec {
                  username = "autumn";
                  homeDirectory = "/home/${username}";
                };
              }
            ];
          };

        nixosConfigurations.miku = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./nixos/configuration.nix

          ];
        };
      };
}
