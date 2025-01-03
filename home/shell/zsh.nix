{ pkgs, homeDirectory, ... }: {
  programs.zsh = {
    enable = true;
    envExtra = builtins.readFile
      "${pkgs.replaceVars ./env.sh { inherit homeDirectory; }}";
    initExtra = ''
      setopt NONOMATCH
    '';
    autosuggestion.enable = true;
    enableCompletion = true;
    completionInit = builtins.readFile ./compinit.zsh;
  };
}
