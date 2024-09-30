{
  inputs,
  self,
  ...
}: {
  flake.darwinConfigurations.zundamon = inputs.nix-darwin.lib.darwinSystem {
    specialArgs = {inherit inputs;};
    modules = [
      ./configuration.nix
      inputs.home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.lirelum = self.homeModules.default;
      }
    ];
  };
}
