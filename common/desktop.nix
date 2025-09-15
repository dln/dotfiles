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
    environment.systemPackages = with pkgs; [
      gnome-ssh-askpass4
      wl-clipboard-rs
    ];

    fonts = {
      fontDir.enable = true;
      fontconfig = {
        allowBitmaps = false;
        antialias = true;
        defaultFonts = {
          monospace = [
            "Berkeley Mono"
            "Symbols Nerd Font Mono"
          ];
          serif = [
            "Inter"
            "Symbols Nerd Font"
          ];
          sansSerif = [
            "Inter"
            "Symbols Nerd Font"
          ];
          emoji = [ "Symbols Nerd Font Mono" ];
        };
        hinting.enable = true;
        hinting.style = "slight";
        hinting.autohint = false;
      };
      packages = with pkgs; [
        go-font
        liberation_ttf
        monaspace
        nerd-fonts.symbols-only
        noto-fonts
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

    services.printing.enable = true;

    services.xserver = {
      enable = true;
      xkb.layout = "se";
      xkb.variant = "us";
    };

    services.greetd =
      let
        steamSession = {
          command = "steam-gamescope";
          user = "gamer";
        };

        base = config.services.displayManager.sessionData.desktops;
        session = {
          command = "${lib.getExe pkgs.tuigreet} --sessions ${base}/share/wayland-sessions:${base}/share/xsessions --remember --remember-user-session --issue";
        };

      in
      {
        enable = true;
        settings = {
          # initial_session = session;
          default_session = session;
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
