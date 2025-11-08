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
    kdePackages.kdenlive
    kdePackages.kdeplasma-addons
    kdePackages.kontact
    kdePackages.korganizer
    kdePackages.kweather
    kdePackages.partitionmanager
    kdePackages.plasma-browser-integration
    kdePackages.polkit-kde-agent-1
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
