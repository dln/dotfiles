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

    programs.ssh.askPassword = "${pkgs.gnome-ssh-askpass4}/bin/gnome-ssh-askpass4";
    programs.ssh.startAgent = true;

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    services.printing.enable = true;

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
