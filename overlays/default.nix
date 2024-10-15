{ inputs, self, ... }:
{
  flake.overlays = {
    unstable = final: prev: {
      unstable = import inputs.nixpkgs-unstable {
        inherit (final) system;
        config.allowUnfree = true;
      };
    };
  };
}
