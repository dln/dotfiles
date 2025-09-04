{
  config,
lib,
   pkgs,
  ...
}:
{
  programs.swaylock = {
    enable = true;
    settings = rec {
      bs-hl-color = "fc618d";
      color = "001122";
      font = "Inter";
      font-size = 32;
      indicator-radius = 150;
      indicator-thickness = 20;
      inside-color = "334455";
      inside-clear-color = inside-color;
      inside-ver-color = inside-color;
      inside-wrong-color = inside-color;
      key-hl-color = "948ae3";
      line-color = "262527";
      line-clear-color = line-color;
      line-ver-color = line-color;
      line-wrong-color = line-color;
      ring-color = "5ad4e6";
      ring-clear-color = ring-color;
      ring-ver-color = ring-color;
      ring-wrong-color = "fc618d";
      separator-color = "403e42";
      text-color = "f7f1ff";
      text-clear-color = text-color;
      text-ver-color = text-color;
      text-wrong-color = text-color;
    };
  };

  services.swayidle = {
    enable = true;
    timeouts = [
      {
        timeout = 600;
        command = "/run/current-system/systemd/bin/loginctl lock-session";
      }
      {
        timeout = 600;
        command = "${lib.getExe config.programs.niri.package} msg action power-off-monitors";
      }
    ];
    events = [
      {
        event = "lock";
        command = lib.getExe config.programs.swaylock.package;
      }
      {
        event = "before-sleep";
        command = "/run/current-system/systemd/bin/loginctl lock-session";
      }
    ];
  };
  }

