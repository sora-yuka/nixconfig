{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch";
      show = "fastfetch";
      fastapi = "echo 'with import <nixpkgs> {}; mkShell { NIX_LD_LIBRARY_PATH = lib.makeLibraryPath [ stdenv.cc.cc ]; NIX_LD = lib.fileContents \"\${stdenv.cc}/nix-support/dynamic-linker\"; shellHook = \"export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH\"; }' > shell.nix && echo 'use nix' > .envrc && direnv allow";
    };

    initContent = ''
      unsetopt nomatch
    '';
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    useTheme = "amro";
  };
}
