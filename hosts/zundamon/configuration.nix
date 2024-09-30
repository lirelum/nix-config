{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
    ./brew.nix
  ];
  services.nix-daemon.enable = true;
  users.users.lirelum.home = /Users/lirelum;
  programs.zsh.enable = true;
  security.pam.enableSudoTouchIdAuth = true;
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };
  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
    };
    channel.enable = false;
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };
  system.stateVersion = 4;
}
