{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
   (nerdfonts.override { fonts = [ "FiraCode" ]; })
    fira-code
    fira-code-symbols
    liberation_ttf 
  ];
}