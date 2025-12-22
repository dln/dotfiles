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
      keepassxc
      plexamp
      signal-desktop
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
        inter
        liberation_ttf
        monaspace
        nerd-fonts.symbols-only
        noto-fonts
        noto-fonts-color-emoji
      ];
    };

    security.polkit.enable = true;

    programs.ssh.enableAskPassword = true;

    services.printing.enable = true;

    services.xserver = {
      enable = true;
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
