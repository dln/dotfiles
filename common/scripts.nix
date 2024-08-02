{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.file = {
    ".local/bin" = {
      recursive = true;
      source = ./../files/scripts;
    };

  };

  home.sessionPath = [ "$HOME/.local/bin" ];
}
