{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.displayManager.sddm.enable = lib.mkForce false;

  services.xserver.displayManager.startx.enable = false;

  services.xserver.displayManager.lightdm = {
    enable = true;
    extraConfig = ''
     logind-check-graphical=true
     logind-load-seats=true

     [Seat:seat0]
     type=local
     xdg-seat=seat0
     autologin-user=
     user-session=plasma

     [Seat:seat1]
     type=local
     xdg-seat=seat1
     autologin-user=gamer
     user-session=plasma
    '';
  };
}
