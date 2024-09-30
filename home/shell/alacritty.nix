{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      shell.program = "${pkgs.zsh}/bin/zsh";
      font = {
        normal = {
          family = "MesloLGL Nerd Font";
          style = "Regular";
        };
        size = if pkgs.system == "aarch64-darwin" then 14 else 11.25;
      };
      window.option_as_alt = "OnlyLeft";
    };
  };
}
