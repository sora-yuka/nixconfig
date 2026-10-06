{ pkgs, ... }: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql;
  };

  virtualisation.docker.enable = true;
  
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
  ];
}
