{ pkgs, ... }: {
  environment.systemPackages = (with pkgs; [ gnome-tweaks ])
    ++ (with pkgs.gnomeExtensions; [ dash-to-dock tray-icons-reloaded ]);
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
  services.gnome = { gnome-browser-connector.enable = true; };
}
