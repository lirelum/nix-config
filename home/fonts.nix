{ pkgs, ... }: {
  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
    emoji = [ "Twitter Color Emoji" ];
    monospace = [ "Fira Code" "Fira Code Symbol" "Noto Sans CJK JP" ];
    sansSerif = [ "Inter" "Noto Sans CJK JP" ];
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
  ];
}
