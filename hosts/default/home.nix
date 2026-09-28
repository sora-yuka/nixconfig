{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home = {
    username = "copa";
    homeDirectory = "/home/copa";
    stateVersion = "26.05";
  };

  imports = [
    ../../modules/home-manager/apps.nix
    ../../modules/home-manager/dev-tool.nix
    ../../modules/home-manager/fonts.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/shell.nix
    ../../modules/home-manager/spicetify.nix
    ../../modules/nixos/gtk-theme.nix
  ];

  programs.home-manager.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
