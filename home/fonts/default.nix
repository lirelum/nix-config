{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    noto-fonts
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
