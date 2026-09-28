{ pkgs, inputs, lib, ... }:

{
  networking.hostName = "nixos-btw";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Bishkek";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ky_KG";
    LC_IDENTIFICATION = "ky_KG";
    LC_MEASUREMENT = "ky_KG";
    LC_MONETARY = "ky_KG";
    LC_NAME = "ky_KG";
    LC_NUMERIC = "ky_KG";
    LC_PAPER = "ky_KG";
    LC_TELEPHONE = "ky_KG";
    LC_TIME = "en_US.UTF-8";
  };

  programs.zsh.enable = true;

  users.users.copa = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    home-manager
    gnome-tweaks
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav
    ffmpeg
    quickshell
  ];

  services.displayManager.ly.enable = true;

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql;
  };

  virtualisation.docker.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["spotify"];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users.copa = import ./home.nix;
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
    ];
  };
}
