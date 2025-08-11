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
    environment.gnome.excludePackages = (
      with pkgs;
      [
        atomix # puzzle game
        baobab # disk usage analyzer
        cheese # webcam tool
        epiphany # web browser
        geary # email reader
        gnome-clocks
        gnome-connections
        gnome-disk-utility
        gnome-logs
        gnome-music
        gnome-photos
        gnome-terminal
        gnome-tour
        snapshot
        hitori # sudoku game
        iagno # go game
        simple-scan
        tali # poker game
        yelp # help viewer
      ]
    );

    fonts = {
      fontDir.enable = true;
      fontconfig = {
        allowBitmaps = false;
        antialias = true;
        defaultFonts = {
          monospace = [ "Berkeley Mono" ];
          serif = [ "Liberation Serif" ];
          sansSerif = [ "Inter" ];
        };
        hinting.enable = true;
        hinting.style = "slight";
      };
      packages = with pkgs; [
        go-font
        inter
        liberation_ttf
        monaspace
        nerd-fonts.symbols-only
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        ubuntu_font_family
      ];
    };

    security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    systemd.user.services.gcr-ssh-agent.environment.SSH_ASKPASS = config.programs.ssh.askPassword;
    security.pam.services.swaylock = { };

    programs.ssh.enableAskPassword = true;
    programs.ssh.askPassword = "${pkgs.gnome-ssh-askpass4}/bin/gnome-ssh-askpass4";

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    services.printing.enable = true;

    services.displayManager.defaultSession = "gnome";

    services.xserver = {
      enable = true;
      xkb.layout = "se";
      xkb.variant = "us";
    };

    services.desktopManager.gnome.enable = true;

    services.displayManager = {
      gdm.enable = true;
      gdm.autoSuspend = false;
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
