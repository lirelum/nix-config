{ username, homeDirectory, ... }: {
  imports = [ ./shell ./fonts.nix ./git.nix ./vscode.nix ./nix-conf.nix ];

  home = {
    inherit username homeDirectory;
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true;
}
