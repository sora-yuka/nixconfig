{ pkgs, inputs, ... }:
{
  home.packages = with pkgs; [
    gnomeExtensions.user-themes
  ];
}
