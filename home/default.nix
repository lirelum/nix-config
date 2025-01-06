# このモジュールはLinuxおよびDarwinと共有する設定
{ username, homeDirectory, importNix, ... }: {
  imports = importNix ./.;

  home = {
    inherit username homeDirectory;
    stateVersion = "24.11";
  };
  programs.home-manager.enable = true;
}
