{ pkgs, inputs, ... }:

let
  sys = pkgs.stdenv.hostPlatform.system;
  zen-browser = inputs.zen-browser.packages."${sys}".default;
  helium = inputs.helium.packages."${sys}".default;
in
{
  home.packages = with pkgs; [
    nix-prefetch-git
    unzip
    fastfetch
    pywal
    timg
    nautilus
    ghostty
    zen-browser
    helium
    telegram-desktop
    discord
    vim
    gapless
    amberol
    yazi
    waybar
    rofi
    hyprshot
    hyprpaper
    cava
    nwg-look
    pavucontrol
    cine
    whatsie
  ];
}
