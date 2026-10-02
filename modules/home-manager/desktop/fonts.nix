{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    jetbrains-mono
    fira-code
    cascadia-code
    source-code-pro
    iosevka
    maple-mono.NF
    maple-mono.truetype # or maple-mono.CN
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.meslo-lg
  ];
}
