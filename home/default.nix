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
        zx
        p7zip
        file
        which
        btop
        lsof
        rstudio-custom
      ]
      ++ (
        if pkgs.system == "x86_64-linux"
        then [
          (discord.override {
            withVencord = true;
            withOpenASAR = true;
          })
          libreoffice
          calibre
          thunderbird
          nextcloud-client
          keepassxc
          retroarch'
        ]
        else []
      );

    home.stateVersion = "24.05";
  };
}
