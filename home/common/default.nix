{ lib, ... }:
{
  imports = [
    ./atuin.nix
    ./broot.nix
    ./devel.nix
    ./fish.nix
    ./gnome.nix
    ./k8s.nix
    ./nix.nix
    ./nvim.nix
    ./scripts.nix
    ./ssh.nix
    ./utils.nix
    ./vcs.nix
    ./web.nix
    ./wezterm.nix
  ];

  options.shelman.desktop.enable = lib.mkEnableOption "Desktop environment";
}
