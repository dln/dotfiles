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

  programs.niri.package = pkgs.niri-unstable;
  programs.niri.enable = true;

  environment.variables.NIXOS_OZONE_WL = "1";

  # environment.systemPackages = with pkgs; [
  #   libsecret
  #   wayland-utils
  # ];

  services.gnome.gnome-keyring.enable = true;
  security.pam.services = {
    login.enableGnomeKeyring = true;
  };
  security.polkit.enable = true;

  programs.seahorse.enable = true;
  programs.ssh.enableAskPassword = true;

  services.dbus.packages = [
    pkgs.gnome-keyring
    pkgs.gcr
  ];
}
