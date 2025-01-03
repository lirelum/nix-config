{ pkgs, config, ... }: { home.packages = config.local.vscode.packages pkgs; }
