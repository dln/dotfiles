{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./home.nix
    ./desktop.nix
  ];

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs; [
      obs-studio-plugins.wlrobs
      obs-studio-plugins.obs-vaapi
      obs-studio-plugins.obs-pipewire-audio-capture
    ];
  };

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [ "azclock@azclock.gitlab.com" ];
    };
  };

  home.packages = with pkgs; [
    endeavour
    picard
    stable.calibre
  ];

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    enableScDaemon = false;
    pinentry.package = pkgs.pinentry-curses;
  };

  ## Neovim headless server

  systemd.user.services."nvim-headless" = {
    Unit = {
      Description = "Neovim headless server";
      StartLimitBurst = 5;
      StartLimitIntervalSec = 600;
      StopWhenUnneeded = true;
    };
    Service = {
      Type = "simple";
      Environment = "PATH=/run/current-system/sw/bin:${config.home.homeDirectory}/.nix-profile/bin";
      ExecStart = "${lib.getExe config.programs.neovim.finalPackage} --headless --listen %t/nvim-headless.sock --cmd 'let g:neovide = v:true'";
      ExecStartPre = "/run/current-system/sw/bin/rm -f %t/nvim-headless.sock";
      Restart = "always";
      RestartSec = 3;
    };
  };

  systemd.user.services."nvim-server" = {
    Unit = rec {
      Description = "Neovim socket activation proxy";
      After = [
        "nvim-server.socket"
        "nvim-headless.service"
      ];
      Requires = After;
    };
    Service = {
      Type = "notify";
      ExecStartPre = "/run/current-system/sw/bin/sleep 1";
      ExecStart = "/run/current-system/sw/lib/systemd/systemd-socket-proxyd --exit-idle-time 600 %t/nvim-headless.sock";
    };
  };

  systemd.user.sockets."nvim-server" = {
    Unit.Description = "Neovim server socket";
    Install.WantedBy = [ "sockets.target" ];
    Socket = {
      ListenStream = "%t/nvim.sock";
      SocketMode = 0600;
      RemoveOnStop = true;
    };
  };

}
