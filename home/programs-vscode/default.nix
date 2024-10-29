{
  pkgs,
  lib,
  ...
}: {
  programs.vscode = lib.mkIf (pkgs.system != "aarch64-darwin") {
    enable = true;
    extensions = with pkgs.vscode-extensions; [james-yu.latex-workshop];
    package = pkgs.vscode.fhsWithPackages (ps: with ps; [texlive.combined.scheme-full]);
  };
}
