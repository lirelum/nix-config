{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    casks = [
      "nextcloud"
      "firefox"
      "keepassxc"
      "calbre"
      "zotero"
    ];
  };
}
