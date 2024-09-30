{
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf (pkgs.system != "aarch64-darwin") {
    programs.firefox.enable = true;
  };
}
