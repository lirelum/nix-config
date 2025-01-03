{ pkgs, ... }: { home.packages = with pkgs; [ keepassxc nextcloud-client ]; }
