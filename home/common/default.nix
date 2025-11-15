{ lib, ... }:
{
  imports = [
    ./atuin.nix
    ./broot.nix
    ./devel.nix
    ./fish.nix
    ./ghostty.nix
    ./helix.nix
    ./k8s.nix
    ./nix.nix
    ./podman.nix
    ./ragenix.nix
    ./scripts.nix
    ./ssh.nix
    ./utils.nix
    ./vcs.nix
    ./web.nix
    ./zellij
  ];

  options.patagia.desktop.enable = lib.mkEnableOption "Desktop environment";
  options.patagia.laptop.enable = lib.mkEnableOption "Laptop";
  options.patagia.oled.enable = lib.mkEnableOption "Darker darks on oled screens";
}
