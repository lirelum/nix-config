{pkgs, ...}: {
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    extraConfig = import ./wezterm.nix pkgs;
  };
}
