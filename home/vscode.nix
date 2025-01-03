{ lib, ... }:
let inherit (lib) mkOption types;
in {
  options.local.vscode = {
    packages = mkOption {
      description = "List of packages to use with vs code, as a function";
      default = null;
      type = types.anything;
    };
  };
  config.local.vscode.packages = (ps:
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
      texlive.combined.scheme-full
      julia-bin
      eslint
      nixfmt-classic
    ]);
}
