{pkgs, ...}: {
  home.packages = with pkgs; [
    libreoffice-fresh
    hunspell
    hunspellDicts.en_US
  ];
}