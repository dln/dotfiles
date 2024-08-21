{ pkgs, ... }:
{
  home.packages = with pkgs; [
    grc
    dust
    jless
    procs
    viddy
  ];

  programs = {
    bat = {
      enable = true;
      config = {
        italic-text = "always";
        paging = "auto";
        style = "plain";
        theme = "ansi";
      };
    };

    bottom.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = false;
    };

    eza = {
      enable = true;
      enableFishIntegration = true;
    };

    fd.enable = true;

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    jq.enable = true;
    less.enable = true;
    lesspipe.enable = true;
    tmux.enable = true;

    ripgrep = {
      enable = true;
      arguments = [
        "--glob=!.git/*"
        "--glob=!.jj/*"
      ];
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [ "--cmd=cd" ];
    };
  };
}
