{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.discover
    kdePackages.elisa
    kdePackages.kdepim-runtime
    kdePackages.kmahjongg
    kdePackages.kmines
    kdePackages.konversation
    kdePackages.kpat
    kdePackages.ksudoku
    kdePackages.ktorrent
    mpv
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    google-chrome
    haruna
    kdePackages.bluedevil
    kdePackages.bluez-qt
    kdePackages.discover
    kdePackages.filelight
    kdePackages.isoimagewriter
    kdePackages.kaccounts-integration
    kdePackages.kaccounts-providers
    kdePackages.kaddressbook
    kdePackages.kasts
    kdePackages.kate
    kdePackages.kauth
    kdePackages.kcalc
    kdePackages.kcharselect
    kdePackages.kclock
    kdePackages.kcolorchooser
    kdePackages.kdeplasma-addons
    kdePackages.knewstuff
    kdePackages.kontact
    kdePackages.korganizer
    kdePackages.ksystemlog
    kdePackages.kweather
    kdePackages.partitionmanager
    kdePackages.plasma-browser-integration
    kdePackages.plasma-systemmonitor
    kdePackages.polkit-kde-agent-1
    kdePackages.qtwebengine
    kdePackages.qtwebview
    kdePackages.signond
    kdiff3
  ];

  programs.kdeconnect.enable = true;
  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];
  };

  programs.ssh.askPassword = lib.getExe pkgs.kdePackages.ksshaskpass;
}
