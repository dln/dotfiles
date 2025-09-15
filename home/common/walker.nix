{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  # imports = [
  #   inputs.niri.homeModules.niri
  # ];

  programs.walker = {
    enable = true;
    runAsService = true;
  };
}
