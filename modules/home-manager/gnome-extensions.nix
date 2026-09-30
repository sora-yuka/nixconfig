{ pkgs, ... }: {
  home.packages = with pkgs.gnomeExtensions; [
    user-themes
    blur-my-shell
  ];

  # Installing an extension does not enable it; must to that declaratively.
  dconf.settings."org/gnome/shell" = {
    disable-user-extensions = false;
    enabled-extensions = with pkgs.gnomeExtensions; [
      user-themes.extensionUuid
      blur-my-shell.extensionUuid
    ];
  };
}
