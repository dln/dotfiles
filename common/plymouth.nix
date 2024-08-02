{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.shelman.plymouth;
in
{
  options.shelman.plymouth.enable = mkEnableOption "Fancy boot splash";

  config = mkIf cfg.enable {
    boot = {
      consoleLogLevel = 0;
      initrd.verbose = false;

      # Hide the OS choice for bootloaders.
      # It's still possible to open the bootloader list by pressing any key
      # It will just not appear on screen unless a key is pressed
      loader.timeout = 0;

      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];

      plymouth = {
        enable = true;
        theme = "spinner_alt";
        themePackages = with pkgs; [
          (adi1090x-plymouth-themes.override { selected_themes = [ "spinner_alt" ]; })
        ];
      };
    };

  };
}
