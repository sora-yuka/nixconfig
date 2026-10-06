{ pkgs, ... }: {
  home.packages = with pkgs; [
    vscode
    python314
    uv
    postman
    nodejs_24
    gnumake
    redis
    openssl
    flutter
    virtualenv
  ];
}
