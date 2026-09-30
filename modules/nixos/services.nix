{ pkgs, ... }: {
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql;
  };

  virtualisation.docker.enable = true;
}
