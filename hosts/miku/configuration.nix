{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "miku";

  networking.networkmanager.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    ipv4 = true;
    ipv6 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    openFirewall = true;
  };

  # Settings for nvidia card
  hardware.opengl.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Locale settings
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "compost:menu";
  };

  # GUI Stuff
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Audio
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User config
  users.users.lirelum = {
    isNormalUser = true;
    description = "lirelum";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBR4/VlVRAwWFxB7zkoKGAt/KSIjAxWxvXkSJGnPxnBn lirelum@miku"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDsnfEEitMxuRzmknVyq0OYG9ZfvEfP0pszSveV5sM6w lirelum@zundamon.local"
    ];
  };
  programs.zsh.enable = true;

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
        flake-registry = "";
        nix-path = config.nix.nixPath;
        trusted-users = [ "@wheel" ];
        substituters = [ "https://helix.cachix.org" ];
        trusted-public-keys = [ "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs=" ];
      };
      channel.enable = false;
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
      };
      optimise = {
        automatic = true;
        dates = [ "weekly" ];
      };
    };
  nixpkgs = {
    config = {
      allowUnfree = true;
    };

    overlays = [ inputs.helix.overlays.default ];
  };

  system.stateVersion = "24.05";
}
