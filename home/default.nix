# このモジュールはLinuxおよびDarwinと共有する設定
{ username, homeDirectory, ... }: {
  imports = [ ./shell ./fonts.nix ./git.nix ./vscode.nix ];

  home = {
    inherit username homeDirectory;
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true;
}
