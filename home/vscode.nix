# VS Codeの一般設定。LinuxおよびDarwinと共有。
{ lib, ... }:
let inherit (lib) mkOption types;
in {
  options.local.vscode = {
    packages = mkOption {
      description = "VS Codeのパッケージのリスト、関数の型";
      default = null;
      type = types.anything;
    };
  };
  config.local.vscode.packages = (ps:
    with ps; [
      bash-language-server
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
