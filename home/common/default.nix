{ lib, ... }:
{
  imports = [
    ./atuin.nix
    ./broot.nix
    ./devel.nix
    ./fish.nix
    ./ghostty.nix
    ./gnome.nix
    ./k8s.nix
    ./nix.nix
    ./nvim
    ./scripts.nix
    ./ssh.nix
    ./tmux.nix
    ./utils.nix
    ./vcs.nix
    ./web.nix
  ];

  options.patagia.desktop.enable = lib.mkEnableOption "Desktop environment";
}
