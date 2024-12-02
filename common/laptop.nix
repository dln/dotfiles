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

  config = mkIf config.laptop.enable {
    environment.systemPackages = with pkgs; [ gnomeExtensions.battery-health-charging ];

    services.fprintd.enable = true;
  };
}
