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
    ./nvim.nix
    ./scripts.nix
    ./ssh.nix
    ./tmux.nix
    ./utils.nix
    ./vcs.nix
    ./web.nix
    ./wezterm.nix
  ];

  options.patagia.desktop.enable = lib.mkEnableOption "Desktop environment";
}
