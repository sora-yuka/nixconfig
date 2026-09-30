# Everything specific to this machine. Shared config lives in ../../modules/nixos.
{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ../../modules/nixos
  ];

  custom.nvidia.enable = true;

  networking.hostName = "nixos-btw";

  programs.zsh.enable = true;

  users.users.copa = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users.copa = import ./home.nix;
  };

  system.stateVersion = "26.05"; # Do not change after install!
}
