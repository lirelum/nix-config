{ pkgs, config, ... }:
let myvscode = pkgs.vscode.fhsWithPackages config.local.vscode.packages;
in {
  programs.vscode = {
    enable = true;
    package = myvscode;
  };
}
