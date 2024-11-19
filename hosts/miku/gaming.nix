{ pkgs, ... }:
let
  lua' = pkgs.runCommand "lua-renamed" { } ''
    mkdir -p $out/lib
    cp -L ${pkgs.lua53Packages.lua}/lib/liblua.so $out/lib/liblua5.3.so.0
  '';
in
{
  # Gaming
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    package = pkgs.steam.override {
      extraPkgs =
        pkgs: with pkgs; [
          lua'
          allegro5
        ];
    };
  };
}
