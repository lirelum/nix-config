{ pkgs, ... }: {
  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
    emoji = [ "Twitter Color Emoji" ];
    monospace = [ "Fira Code" "Fira Code Symbol" "Source Han Sans" ];
    sansSerif = [ "Inter" "Source Han Sans" ];
    serif = [ "DejaVu Serif" "Source Han Serif" ];
  };
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    twemoji-color-font
    inter
    source-han-sans-japanese
    source-han-serif-japanese
    source-han-code-jp
  ];
}
