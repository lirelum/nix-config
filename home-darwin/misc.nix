{ pkgs, ... }: { home.packages = with pkgs.unstable; [ coreutils-full ]; }
