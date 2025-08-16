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
    security.pam.services.greetd.enableGnomeKeyring = true;
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

    services.xserver = {
      enable = true;
      xkb.layout = "se";
      xkb.variant = "us";
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri-session";
          user = "greeter";
        };
      };
    };

    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
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
