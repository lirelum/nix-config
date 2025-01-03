{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nix-alien.url = "github:thiagokokada/nix-alien";
  };

  outputs =
    inputs@{ self, nixpkgs, nixpkgs-darwin, home-manager, flake-utils, ... }:
    let
      inherit (self) outputs;
      inherit (flake-utils.lib) eachDefaultSystem;
      selectNixpkgs = (system:
        if builtins.match "[A-Za-z0-9]+-darwin" system != null then
          nixpkgs-darwin
        else
          nixpkgs);
    in eachDefaultSystem (system:
      let pkgs = (selectNixpkgs system).legacyPackages.${system};
      in {
        formatter = pkgs.nixfmt-classic;
        packages = import ./pkgs pkgs;
      }) // {

        overlays.default =
          (final: prev: { local = outputs.packages.${final.system}; });

        homeConfigurations."lirelum@zundamon" =
          home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs-darwin.legacyPackages.aarch64-darwin;
            extraSpecialArgs = rec {
              inherit inputs outputs;
              username = "lirelum";
              homeDirectory = "/Users/${username}";
            };
            modules = [ ./home ];
          };

        nixosConfigurations.miku = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = rec {
                username = "autumn";
                homeDirectory = "/home/${username}";
                inherit inputs outputs;
              };
              home-manager.users.autumn.imports = [ ./home ./home-nixos ];
            }
          ];
        };
      };
}
