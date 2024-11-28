{pkgs, ...}: {
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
      };
      window.option_as_alt = "OnlyLeft";
    };
  };
}
