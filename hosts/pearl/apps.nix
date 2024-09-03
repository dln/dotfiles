{
  lib,
  pkgs,
  ...
}:
{
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    calibre
    gimp
    gnomeExtensions.emoji-copy
    gnomeExtensions.just-perfection
    gnomeExtensions.vitals
    gnome-pomodoro
    gnome-tweaks
    hitori
    inkscape
    krita
    moonlight-qt
    obsidian
    pavucontrol
    plexamp
    signal-desktop
  ];

  environment.gnome.excludePackages =
    [
    ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
