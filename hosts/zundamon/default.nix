{ inputs, self, ... }:
{
  flake.darwinConfigurations.zundamon = inputs.nix-darwin.lib.darwinSystem {
    specialArgs = {
      inherit inputs self;
    };
    modules = [
      ./configuration.nix
      inputs.home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit inputs;
        };
        home-manager.users.lirelum = self.homeModules.default;
      }
      inputs.nix-index-database.darwinModules.nix-index
      { programs.nix-index-database.comma.enable = true; }
    ];
  };
}
