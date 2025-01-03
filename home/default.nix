{ username, homeDirectory, ... }: {
  imports = [ ./shell ./fonts.nix ./git.nix ./vscode.nix ];

  home = {
    inherit username homeDirectory;
    stateVersion = "24.11";
  };
}
