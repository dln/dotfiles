{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.shelman.podman;
in
{
  options.shelman.laptop.enable = mkEnableOption "Laptop tools and configuration";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ gnomeExtensions.battery-health-charging ];

    services.fprintd.enable = true;
  };
}
