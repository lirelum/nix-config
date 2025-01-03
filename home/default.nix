{ username, homeDirectory, ... }: {
  imports = [ ./shell ./fonts.nix ./git.nix ];

  home = {
    inherit username homeDirectory;
    stateVersion = "24.11";
  };
}
