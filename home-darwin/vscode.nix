{ pkgs, config, ... }: {
  home.packages = config.local.vscode.packages (_: []) pkgs.unstable;
}
