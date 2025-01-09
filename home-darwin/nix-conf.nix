{ lib, inputs, outputs, config, pkgs, ... }: {
  nix = let flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      nix-path = config.nix.nixPath;
    };

    registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    package = pkgs.nix;
  };
  nixpkgs = {
    overlays = [ outputs.overlays.default ];
    config = { allowUnfree = true; };
  };
}