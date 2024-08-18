{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  system.switch = {
    enable = false;
    enableNg = true;
  };

  boot = {
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "thunderbolt"
        "nvme"
        "usb_storage"
        "sd_mod"
      ];
      kernelModules = [ ];
      luks.devices."enc".device = "/dev/disk/by-uuid/e7c7a230-b321-4e6d-869c-6c2d858455d2";
      systemd.enable = true;
    };
    kernelModules = [ "kvm-intel" ];
    kernelParams = [ "mitigations=off" ];
    extraModulePackages = [ ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/81e5205d-fe1e-458f-82e1-d60ab03c0a1d";
    fsType = "btrfs";
    options = [
      "noatime"
      "nodiratime"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D6C0-1A05";
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
  hardware.nitrokey.enable = true;

  swapDevices = [ { device = "/dev/disk/by-uuid/c9cc5270-87b0-4ed4-9891-7df924b0f55a"; } ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  environment.systemPackages = with pkgs; [
    android-tools
    android-udev-rules
    mullvad-vpn
  ];

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];

  programs.adb.enable = true;

  networking = {
    hostName = "dinky";
    domain = "aarn.shelman.io";
    search = [
      "shelman.io"
      "aarn.shelman.io"
    ];
    useDHCP = lib.mkDefault true;
  };

  networking.networkmanager.wifi.backend = "iwd";

  services.mullvad-vpn.enable = true;

  users.users.dln = {
    isNormalUser = true;
    description = "Daniel Lundin";
    extraGroups = [
      "adbusers"
      "lp"
      "nitrokey"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAILwakA+EeuR23vRhjvjMkzK+FtWIhpnbs7z1pfnBehCUAAAABHNzaDo= dln@dinky"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIJNOBFoU7Cdsgi4KpYRcv7EhR/8kD4DYjEZnwk6urRx7AAAABHNzaDo= dln@nemo"
    ];
  };

  shelman = {
    desktop.enable = true;
    laptop.enable = true;
    plymouth.enable = true;
    podman.enable = true;
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "dln";
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  nix.buildMachines = [
    {
      hostName = "nemo.aarn.shelman.io";
      sshUser = "nixremote";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      maxJobs = 32;
      speedFactor = 2;
      supportedFeatures = [ ];
      mandatoryFeatures = [ ];
    }
  ];
  nix.distributedBuilds = true;
  nix.extraOptions = ''
    builders-use-substitutes = true
  '';

  system.stateVersion = "24.05"; # Did you read the comment?
}
