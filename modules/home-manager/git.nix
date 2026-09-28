{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.email = "feelingjeez@gmail.com";
      user.name = "sora-yuka";
      init.defaultBranch = "main";
    };
  };
}
