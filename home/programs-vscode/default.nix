{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [ james-yu.latex-workshop ];
    package = pkgs.vscode.fhsWithPackages (ps: with ps; [ texlive.combined.scheme-full ]);
  };
}
