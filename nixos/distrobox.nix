# ディストロボックスは、NixOSで実行できないプログラムを使用向け
# 現在、使用しません
{ pkgs, ... }: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };
  environment.systemPackages = with pkgs; [ xorg.xhost distrobox ];
}
