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
    '';
    matchBlocks."*" = {
      addKeysToAgent = "yes";
      compression = false;
      controlMaster = "auto";
      controlPath = "\${XDG_RUNTIME_DIR}/ssh_control:%h:%p:%r";
      controlPersist = "15m";
      forwardAgent = false;
      hashKnownHosts = false;
      serverAliveCountMax = 3;
      serverAliveInterval = 0;
      userKnownHostsFile = "~/.ssh/known_hosts";
    };
  };

  services.ssh-agent.enable = true;
  systemd.user.services.ssh-agent.Service.Environment = [
    "SSH_ASKPASS=${config.home.sessionVariables.SSH_ASKPASS}"
    "SSH_ASKPASS_REQUIRE=force"
  ];

  home.sessionVariables = {
    # https://wiki.archlinux.org/title/KDE_Wallet#Using_the_KDE_Wallet_to_store_ssh_key_passphrases
    SSH_ASKPASS = lib.getExe pkgs.kdePackages.ksshaskpass;
    SSH_ASKPASS_REQUIRE = "prefer";
    SSH_AUTH_SOCK = "\${XDG_RUNTIME_DIR}/${config.services.ssh-agent.socket}";
  };

  systemd.user.sessionVariables = config.home.sessionVariables;

  # services.ssh-tpm-agent.enable = true;
}
