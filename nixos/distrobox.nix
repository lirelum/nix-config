# ディストロボックスは、NixOSで実行できないプログラムを使用向け
# 現在、Ciderのみに使用
{ pkgs, ... }: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  environment.systemPackages = with pkgs; [ distrobox ];
}
