{ pkgs, config, ... }:
let
  myvscode = pkgs.unstable.vscode.fhsWithPackages (config.local.vscode.packages (ps: with ps; [openssh which]));
in {
  programs.vscode = {
    enable = true;
    package = myvscode;
  };
}
