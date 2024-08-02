{
  config,
  lib,
  pkgs,
  ...
}:
{
  nix.settings.allowed-users = [
    "@wheel"
    "root"
  ];

  boot.specialFileSystems = lib.mkIf (
    !config.security.rtkit.enable && !config.security.polkit.enable
  ) { "/proc".options = [ "hidepid=2" ]; };

  boot.kernel.sysctl."kernel.dmesg_restrict" = 1;

  environment.systemPackages = [ pkgs.doas-sudo-shim ];

  security = {
    doas = {
      enable = true;
      extraRules = [
        {
          groups = [ "wheel" ];
          keepEnv = true;
          persist = true;
        }
      ];
    };
    sudo.enable = false;
  };

  services.openssh = {
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    # prevents mutable /home/$user/.ssh/authorized_keys from being loaded to ensure that all user keys are config managed
    # authorizedKeysFiles = lib.mkForce [ "/etc/ssh/authorized_keys.d/%u" ];
  };

  users.users.root.hashedPassword = "!";
}
