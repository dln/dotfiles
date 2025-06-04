{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.patagia.desktop.enable {

    home.packages = with pkgs; [ protonmail-bridge ];

    systemd.user.services.protonmail-bridge = {
      Unit = {
        Description = "ProtonMail Bridge";
        After = [
          "graphical-session.target"
          "network.target"
        ];
      };
      Service = {
        ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --log-level info --noninteractive";
        Restart = "on-failure";
        RestartSec = 5;
        Environment = [
          "GNOME_KEYRING_CONTROL=%t/keyring"
          "PATH=${pkgs.gnome-keyring}/bin"
          "SSH_AUTH_SOCK=%t/keyring/ssh"
        ];
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };

  };
}
