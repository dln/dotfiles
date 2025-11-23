{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    extraConfig = ''
      PreferredAuthentications publickey
      TCPKeepAlive true
    '';
    matchBlocks."*" = {
      # addKeysToAgent = "yes";
      compression = false;
      controlMaster = "auto";
      controlPath = "\${XDG_RUNTIME_DIR}/ssh_control:%h:%p:%r";
      controlPersist = "15m";
      forwardAgent = false;
      hashKnownHosts = false;
      serverAliveCountMax = 30;
      serverAliveInterval = 10;
      userKnownHostsFile = "~/.ssh/known_hosts";
    };
  };

  services.ssh-agent = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    socket = "ssh-agent.local";
  };

  systemd.user.services.ssh-agent = {
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      Environment = [
        "SSH_ASKPASS=${config.home.sessionVariables.SSH_ASKPASS}"
        "SSH_ASKPASS_REQUIRE=force"
      ];
      ExecStartPre = "${pkgs.coreutils}/bin/sleep 3"; # Hack
    };
    Unit.After = [
      "graphical-session.target"
    ];
  };

  home.sessionVariables = {
    # https://wiki.archlinux.org/title/KDE_Wallet#Using_the_KDE_Wallet_to_store_ssh_key_passphrases
    SSH_ASKPASS = lib.getExe pkgs.kdePackages.ksshaskpass;
    SSH_ASKPASS_REQUIRE = "prefer";
  };

  systemd.user.sessionVariables = config.home.sessionVariables;

  # services.ssh-tpm-agent.enable = true;
}
