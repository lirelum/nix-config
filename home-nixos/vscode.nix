{ pkgs, config, ... }:
let
  myvscode = pkgs.unstable.vscode.fhsWithPackages config.local.vscode.packages;
in {
  programs.vscode = {
    enable = true;
    package = myvscode;
  };
}
