{ pkgs, config, ... }:
let
  myvscode = pkgs.unstable.vscode.fhsWithPackages (config.local.vscode.packages (ps: with ps; [openssh which]));
in {
  home.packages = (config.local.vscode.packages (ps: []) pkgs.unstable);
}
