{ pkgs, ... }:

let
  yorhaTheme = pkgs.fetchFromGitHub {
    owner = "OliveThePuffin";
    repo = "yorha-grub-theme";
    rev = "4d9cd37baf56c4f5510cc4ff61be278f11077c81";

    # Generated via: nix-prefetch https://github.com/feanorknd/feanor-grub-theme --rev 4d9cd37...
    hash = "sha256-XVzYDwJM7Q9DvdF4ZOqayjiYpasUeMhAWWcXtnhJ0WQ=";
  };
in
{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };

    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;

      theme = "${yorhaTheme}/yorha-1920x1080";
    };

    timeout = 8;
  };
}
