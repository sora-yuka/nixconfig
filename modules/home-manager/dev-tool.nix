{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vscode
    python314
    uv
    virtualenv
    postman
    direnv
    nix-direnv
    nodejs_24
    gnumake42
    docker
    redis
    openssl
    flutter
  ];
}
