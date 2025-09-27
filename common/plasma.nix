{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.desktopManager.plasma6.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    haruna
    kdePackages.discover
    kdePackages.isoimagewriter
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kclock
    kdePackages.kcolorchooser
    kdePackages.kdenlive
    kdePackages.partitionmanager
    kdePackages.polkit-kde-agent-1
    kdePackages.sddm-kcm
    kdiff3
  ];

  programs.kdeconnect.enable = true;
  networking.firewall = {
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };

  programs.ssh.askPassword = lib.getExe pkgs.kdePackages.ksshaskpass;
}
