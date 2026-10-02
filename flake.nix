{
  description = "Copa's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium.url = "github:schembriaiden/helium-browser-nix-flake";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { nixpkgs, ... }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [./hosts/nixos-btw];
    };

    # `nix fmt` formats every .nix file in the repo.
    formatter.${system} = pkgs.alejandra;

    # `nix flake init -t /etc/nixos#fastapi` in a project directory.
    templates.fastapi = {
      path = ./templates/fastapi;
      description = "FastAPI dev shell (libstdc++ via LD_LIBRARY_PATH) + direnv";
    };
  };
}
