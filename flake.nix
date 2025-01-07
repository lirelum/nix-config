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
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-darwin, nixpkgs-unstable
    , home-manager, flake-utils, ... }:
    let
      inherit (self) outputs;
      inherit (flake-utils.lib) eachDefaultSystem;
      selectNixpkgs = (system:
        let
          settings = {
            inherit system;
            config = { allowUnfree = true; };
            overlays = [ outputs.overlays.default ];
          };
        in if builtins.match "[A-Za-z0-9_-]+-darwin" system != null then
          import nixpkgs-darwin settings
        else
          import nixpkgs settings);
    in eachDefaultSystem (system:
      let pkgs = (selectNixpkgs system);
      in {
        formatter = pkgs.nixfmt-classic;
        packages = import ./pkgs {inherit pkgs;};
      }) // {

        overlays.default = (final: prev: {
          local = outputs.packages.${final.system};
          unstable = import nixpkgs-unstable {
            system = final.system;
            config.allowUnfree = true;
          };
        });

        homeConfigurations."lirelum@zundamon" =
          home-manager.lib.homeManagerConfiguration
          (let system = "aarch64-darwin";
          in {
            pkgs = selectNixpkgs system;
            extraSpecialArgs = rec {
              inherit inputs outputs;
              username = "lirelum";
              homeDirectory = "/Users/${username}";
            };
            modules = [ ./home ./home-darwin ];
          });

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
