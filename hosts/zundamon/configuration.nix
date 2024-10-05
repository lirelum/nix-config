{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [ ./brew.nix ];
  services.nix-daemon.enable = true;
  users.users.lirelum.home = /Users/lirelum;
  programs.zsh.enable = true;
  security.pam.enableSudoTouchIdAuth = true;
  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
    flake = {
      setFlakeRegistry = false;
      setNixPath = false;
    };
  };
  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        nix-path = config.nix.nixPath;
      };
      channel.enable = false;
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      gc = {
        automatic = true;
        interval = {
          Weekday = 0;
          Hour = 0;
          Minute = 0;
        };
        options = "--delete-older-than 30d";
      };
      optimise = {
        automatic = true;
        interval = {
          Weekday = 0;
          Hour = 0;
          Minute = 0;
        };
      };
    };

  system.stateVersion = 4;
}
