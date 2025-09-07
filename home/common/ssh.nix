{ ... }:
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
}
