{ inputs, self, ... }:
{
  flake.homeModules.default =
    { pkgs, ... }:
    {
      imports = [
        ./shell
        ./programs-helix
        ./fonts
        ./programs-gpg
        ./programs-git
        ./programs-firefox
        ./programs-vscode
      ];

      home.packages =
        with pkgs;
        [
          zip
          unzip
          zx
          p7zip
          file
          which
          btop
          lsof
        ]
        ++ (
          if pkgs.system == "x86_64-linux" then
            [
              (discord.override {
                withVencord = true;
                withOpenASAR = true;
              })
              libreoffice
              calibre
              thunderbird
              nextcloud-client
              keepassxc
            ]
          else
            [ ]
        );

      home.stateVersion = "24.05";
    };
}
