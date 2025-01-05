{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.patagia.podman;
in
{
  options.patagia.desktop.enable = mkEnableOption "Desktop environment and common applications";

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ gnome-ssh-askpass4 ];

    # Excluding some GNOME applications from the default install
    environment.gnome.excludePackages =
      (with pkgs; [
        gnome-connections
        gnome-photos
        gnome-tour
        snapshot
      ])
      ++ (with pkgs; [
        atomix # puzzle game
        baobab # disk usage analyzer
        cheese # webcam tool
        epiphany # web browser
        geary # email reader
        gnome-clocks
        gnome-contacts
        gnome-disk-utility
        gnome-logs
        gnome-music
        gnome-terminal
        hitori # sudoku game
        iagno # go game
        simple-scan
        tali # poker game
        yelp # help viewer
      ]);

    fonts = {
      fontDir.enable = true;
      fontconfig = {
        allowBitmaps = false;
        antialias = true;
        defaultFonts = {
          serif = [ "Liberation Serif" ];
          sansSerif = [ "Inter" ];
        };
        hinting.enable = true;
        hinting.style = "slight";
        subpixel.rgba = "rgb";
      };
      packages = with pkgs; [
        inter
        liberation_ttf
        monaspace
        nerd-fonts.symbols-only
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        roboto
        ubuntu_font_family
      ];
    };

    programs.ssh.askPassword = "${pkgs.gnome-ssh-askpass4}/bin/gnome-ssh-askpass4";
    programs.ssh.startAgent = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    services.gnome.gnome-keyring.enable = true;

    services.printing.enable = true;

    services.displayManager.defaultSession = "gnome";

    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      displayManager.gdm.autoSuspend = false;
      desktopManager.gnome.enable = true;
      xkb.layout = "se";
      xkb.variant = "us";
    };

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
