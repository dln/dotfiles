{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib;
{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  nixpkgs.overlays = [ inputs.niri.overlays.niri ];

  environment.systemPackages = with pkgs; [
    alacritty
    xwayland-satellite-unstable
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  systemd.user.services.niri-flake-polkit.enable = false;

  security = {
    pam.services.swaylock = { };
    rtkit.enable = true;
  };

  programs.seahorse.enable = true;
  programs.ssh.enableAskPassword = true;

  services.dbus.packages = [
    pkgs.gnome-keyring
    pkgs.gcr
  ];

  environment.variables.NIXOS_OZONE_WL = "1";
}
