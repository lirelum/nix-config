{ pkgs, ... }: {
  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
    emoji = [ "Twitter Color Emoji" ];
    monospace = [ "Fira Code" "Fira Code Symbol" "Source Han Sans" ];
    sansSerif = [ "Inter" "Source Han Sans" ];
    serif = [ "DejaVu Serif" "Source Han Serif" ];
  };
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    fira-code
    fira-code-symbols
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
    twemoji-color-font
    open-sans
    ubuntu_font_family
    inter
    source-han-sans-japanese
    source-han-serif-japanese
    source-han-code-jp
  ];
}
