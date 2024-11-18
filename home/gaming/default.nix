{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    inputs.nix-gaming.packages.${pkgs.system}.mo2installer
    pkgs.heroic
  ];
}
