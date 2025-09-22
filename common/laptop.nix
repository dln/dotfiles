{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf mkEnableOption;
in
{
  options.patagia.laptop.enable = mkEnableOption "Laptop tools and configuration";

  config = mkIf config.patagia.laptop.enable {
    services.fprintd.enable = true;
  };
}
