{
  pkgs,
  inputs,
  ...
}: let
  sys = pkgs.stdenv.hostPlatform.system;
in {
  home.packages = with pkgs; [
    nix-prefetch-git
    unzip
    fastfetch
    pywal
    timg
    nautilus
    ghostty
    inputs.zen-browser.packages.${sys}.default
    inputs.helium.packages.${sys}.default
    telegram-desktop
    discord
    vim
    tree
    gapless
    amberol
    yazi
    waybar
    quickshell
    rofi
    hyprshot
    hyprpaper
    hyprlock
    cava
    nwg-look
    pavucontrol
    cine
    playerctl
    whatsie
  ];
}
