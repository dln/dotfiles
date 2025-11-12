{
  pkgs,
  ...
}:
{
  imports = [
    ./vcs.nix
  ];

  home = {
    username = "dln";
    homeDirectory = "/home/dln";
    language = {
      base = "en_US.UTF-8";
      measurement = "sv_SE.UTF-8";
      monetary = "sv_SE.UTF-8";
      numeric = "sv_SE.UTF-8";
      paper = "sv_SE.UTF-8";
      telephone = "sv_SE.UTF-8";
      time = "sv_SE.UTF-8";
    };
    packages = with pkgs; [
      asciinema
      ouch
      toolbox
    ];
  };

  programs.atuin.settings = {
    show_tabs = false;

    cwd_filter = [
      "^~/media"
      "^/home/dln/media"
      "^/tmp"
    ];

    history_filter = [
      "^kubectl create secret.*--from-literal"
      "^kubectl delete ns"
      "^kubectl delete namespace"
      "^talosctl reset"
    ];
  };

  programs.ssh.matchBlocks = {
    devel = {
      hostname = "10.1.100.20";
      forwardAgent = true;
      localForwards = [
        {
          bind.address = "localhost";
          bind.port = 8000;
          host.address = "localhost";
          host.port = 8000;
        }
        {
          bind.address = "localhost";
          bind.port = 8080;
          host.address = "localhost";
          host.port = 8080;
        }
        {
          bind.address = "localhost";
          bind.port = 8484;
          host.address = "localhost";
          host.port = 8484;
        }
      ];
    };
  };

  home.stateVersion = "25.05"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
}
