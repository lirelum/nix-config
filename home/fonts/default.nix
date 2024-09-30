{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    (nerdfonts.override {
      fonts = [
        "DejaVuSansMono"
        "Hack"
        "Meslo"
        "Noto"
      ];
    })
  ];
}
