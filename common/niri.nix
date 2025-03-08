{
  user,
  lib,
  pkgs,
  inputs',
  ...
}:
{
  programs.niri = {
    enable = true;
  };

  services.greetd = {
    enable = true;
    vt = 2;
    settings = rec {
      initial_session = {
        command = "${lib.getExe pkgs.greetd.tuigreet} --remember --time --cmd ${lib.getExe' pkgs.niri "niri-session"}";
      };
      default_session = initial_session;
    };
  };

}
