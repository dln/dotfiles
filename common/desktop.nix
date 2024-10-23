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

    security.polkit.enable = true;

    # services.printing.enable = true;

    # services.displayManager.defaultSession = "gnome";
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";
        };
      };
    };

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      audio.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
