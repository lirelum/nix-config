{
  inputs,
  self,
  ...
}: {
  flake.homeModules.default = {pkgs, ...}: let
    rstudio-custom = pkgs.unstable.rstudioWrapper.override {
      packages = with pkgs.unstable.rPackages; [ggplot2];
    };
    retroarch' = pkgs.retroarch.override {
      cores = with pkgs.libretro; [
        snes9x
      ];
    };
  in {
    imports = [
      ./shell
      ./programs-helix
      ./fonts
      ./programs-gpg
      ./programs-git
      ./programs-firefox
      ./programs-vscode
    ];

    home.packages = with pkgs;
      [
        zip
        unzip
        xz
        p7zip
        file
        which
        btop
        lsof
        vesktop
      ]
      ++ (
        if pkgs.system == "x86_64-linux"
        then [
          libreoffice
          calibre
          thunderbird
          nextcloud-client
          keepassxc
          rstudio-custom
          retroarch'
          openmw
        ]
        else []
      );

    nixpkgs.config.allowUnfree = true;

    home.stateVersion = "24.05";
  };
}
