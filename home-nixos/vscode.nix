{ pkgs, ... }:
let
  myvscode = pkgs.vscode.fhsWithPackages (ps:
    with ps; [
      shellcheck
      shfmt
      nixfmt-classic
      nil
      rustup
      dhall-lsp-server
      elixir
      quarto
      ghc
      cabal-install
      stack
      neovim
    ]);
in {
  programs.vscode = {
    enable = true;
    package = myvscode;
  };
}
