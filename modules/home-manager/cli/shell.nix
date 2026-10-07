{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos-btw";
      clib = "nix flake init -t /etc/nixos#clib && direnv allow";
      ui = "uv init --no-package .";
      ud = "uv add";
      ur = "uv run";
    };

    initContent = ''
      unsetopt nomatch
      bindkey '^H' backward-kill-word
    '';
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    useTheme = "amro";
  };
}
