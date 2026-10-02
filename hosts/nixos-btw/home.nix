{ ... }: {
  imports = [ ../../modules/home-manager ];

  home = {
    username = "copa";
    homeDirectory = "/home/copa";
    stateVersion = "26.05";
  };
}
