{ pkgs, ... }: {
  home.packages = with pkgs; [ vesktop element-desktop thunderbird ];
}
