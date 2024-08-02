{ ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = false;
    withPython3 = false;
    withRuby = false;
  };

  xdg.configFile = {
    "nvim" = {
      recursive = true;
      source = ./../../files/config/nvim;
    };
  };
}
