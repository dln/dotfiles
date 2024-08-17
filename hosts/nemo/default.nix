{
  lib,
  config,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    extraModulePackages = with config.boot.kernelPackages; [ nct6687d ];
    initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nct6687"
      "nvme"
      "firewire_ohci"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    initrd.kernelModules = [ "nct6687" ];
    kernelModules = [
      "nct6687"
      "kvm-intel"
    ];
    extraModprobeConfig = ''
      options nct6687 force=1
    '';
    kernelParams = [ "mitigations=off" ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b9514f88-1c83-4596-999f-7e3640db6a86";
    fsType = "btrfs";
    options = [
      "subvol=@"
      "noatime"
      "nodiratime"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/b9514f88-1c83-4596-999f-7e3640db6a86";
    fsType = "btrfs";
    options = [
      "subvol=@home"
      "noatime"
      "nodiratime"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2670-0FCA";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
      intel-media-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  hardware.enableAllFirmware = true;

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking = {
    hostName = "nemo"; # Define your hostname.
    domain = "aarn.shelman.io";
    nameservers = [
      "10.1.100.11"
      "10.1.100.12"
      "10.1.100.13"
    ];
    firewall.enable = false;
    networkmanager.enable = false;
    useDHCP = false;
    wireless.iwd = {
      enable = true;
      settings = {
        DriverQuirks.PowerSaveDisable = "*";
        Network = {
          EnableIPv6 = false;
          NameResolvingService = "systemd";
        };
        Scan.DisablePeriodicScan = true;
        Settings = {
          AutoConnect = true;
        };
      };
    };
  };

  services.nscd.enableNsncd = false;

  systemd.network.enable = true;
  systemd.network.networks."10-wifi" = {
    matchConfig.Name = "wlan1";
    address = [ "10.1.100.20/22" ];
    gateway = [ "10.1.100.1" ];
    linkConfig.RequiredForOnline = "routable";
  };

  # FIXME: pam_rssh is broken from rust 1.80 upgrade
  # environment.systemPackages = [ pkgs.pam_rssh ];
  # security = {
  #   pam.services.doas =
  #     { config, ... }:
  #     {
  #       rules.auth.rssh = {
  #         order = config.rules.auth.ssh_agent_auth.order - 1;
  #         control = "sufficient";
  #         modulePath = "${pkgs.pam_rssh}/lib/libpam_rssh.so";
  #         settings.authorized_keys_command = pkgs.writeShellScript "get-authorized-keys" ''
  #           cat "/etc/ssh/authorized_keys.d/$1"
  #         '';
  #       };
  #     };
  # };

  services.resolved = {
    enable = true;
    domains = [
      "shelman.io"
      "aarn.shelman.io"
    ];
    llmnr = "false";
    fallbackDns = [ "9.9.9.9" ];
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      StreamLocalBindUnlink = true;
    };
  };

  services.sunshine = {
    enable = true;
    openFirewall = true;
    settings = { };
  };

  shelman = {
    desktop.enable = true;
    plymouth.enable = true;
    podman.enable = true;
  };

  environment.systemPackages = with pkgs; [
    ffado
    lm_sensors
    openconnect
  ];

  programs.coolercontrol.enable = true;

  users.users.dln = {
    isNormalUser = true;
    description = "Daniel Lundin";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIIHMAEZx02kbHrEygyPQYStiXlrIe6EIqBCv7anIkL0pAAAABHNzaDo= dln@dinky"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIJNOBFoU7Cdsgi4KpYRcv7EhR/8kD4DYjEZnwk6urRx7AAAABHNzaDo= dln@nemo"
    ];
  };

  users.users.lsjostro = {
    isNormalUser = true;
    description = "Lars Sjöström";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "sk-ecdsa-sha2-nistp256@openssh.com AAAAInNrLWVjZHNhLXNoYTItbmlzdHAyNTZAb3BlbnNzaC5jb20AAAAIbmlzdHAyNTYAAABBBJ10mLOpInoqDaySyrxbzvcOrJfLw48Y6eWHa9501lw+hEEBXya3ib7nlvpCqEQJ8aPU5fVRqpkOW5zSimCiRbwAAAAEc3NoOg=="
      "sk-ecdsa-sha2-nistp256@openssh.com AAAAInNrLWVjZHNhLXNoYTItbmlzdHAyNTZAb3BlbnNzaC5jb20AAAAIbmlzdHAyNTYAAABBBLpoKvsZDIQQLfgzJhe1jAQubBNxjydkj8UfdUPaSXqgfB02OypMOC1m5ZuJYcQIxox0I+4Z8xstFhYP6s8zKZwAAAAEc3NoOg=="
    ];
  };

  users.users.nixremote = {
    name = "nixremote";
    isSystemUser = true;
    shell = pkgs.bashInteractive;
    group = "nixremote";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEJjhHem/l3p/79Rqo3Wtk9ksxmt7Q/pkRdnXiNzP4Cf"
    ];
  };
  users.groups.nixremote = { };

  nix.settings.trusted-users = [
    "dln"
    "lsjostro"
    "nixremote"
  ];

  system.stateVersion = "24.05"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
}
