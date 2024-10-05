{ inputs, self, ... }:
{
  flake.nixosConfigurations.miku = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = {
      inherit inputs;
    };
    modules = [
      ./configuration.nix
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit inputs;
        };
        home-manager.users.lirelum = self.homeModules.default;
      }
      inputs.nix-index-database.nixosModules.nix-index
      { programs.nix-index-database.comma.enable = true; }
    ];
  };
}
