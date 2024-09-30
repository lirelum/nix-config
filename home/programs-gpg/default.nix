{
  lib,
  pkgs,
  ...
}: {
  programs.gpg.enable = true;
  services.gpg-agent = lib.mkIf (pkgs.system != "aarch64-darwin") {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
