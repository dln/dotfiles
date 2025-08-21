{ lib, ... }:
{
  imports = [
    ./atuin.nix
    ./broot.nix
    ./devel.nix
    ./fish.nix
    ./ghostty.nix
    ./k8s.nix
    ./niri.nix
    ./nix.nix
    ./nvim
    ./ragenix.nix
    ./scripts.nix
    ./ssh.nix
    ./utils.nix
    ./vcs.nix
    ./waybar.nix
    ./web.nix
  ];

  options.patagia.desktop.enable = lib.mkEnableOption "Desktop environment";
  options.patagia.laptop.enable = lib.mkEnableOption "Laptop";
  options.patagia.oled.enable = lib.mkEnableOption "Darker darks on oled screens";
}
