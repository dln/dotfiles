{
  lib,
  config,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./harmonia.nix
    ./steam.nix
    ./woodpecker.nix
  ];

  boot = {
    extraModulePackages = with config.boot.kernelPackages; [
      nct6687d
      v4l2loopback
    ];
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
    initrd.kernelModules = [
      "amdgpu"
      "nct6687"
    ];
    kernelModules = [
      "nct6687"
      "kvm-intel"
    ];
    extraModprobeConfig = ''
      options nct6687 force=1
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
    kernelParams = [
      "mitigations=off"
      # "amdgpu.abmlevel=0"
    ];
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
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      libvdpau-va-gl
      rocmPackages.clr.icd
      vaapiVdpau
      vpl-gpu-rt
      vulkan-extension-layer
      vulkan-headers
      vulkan-loader
      vulkan-tools
      vulkan-validation-layers
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      vulkan-extension-layer
      vulkan-headers
      vulkan-loader
      vulkan-tools
      vulkan-validation-layers
    ];
  };

  hardware.amdgpu = {
    initrd.enable = true;
    overdrive.enable = true;
  };

  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  hardware.enableAllFirmware = true;

  hardware.keyboard.qmk.enable = true;

  hardware.xone.enable = true;

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  networking = {
    hostName = "nemo"; # Define your hostname.
    domain = "aarn.patagia.net";
    nameservers = [
      "10.1.100.11"
      "10.1.100.12"
      "10.1.100.13"
    ];
    firewall.enable = false;
    networkmanager.enable = true;
    useDHCP = false;
  };

  services.nscd.enableNsncd = false;

  systemd.network.enable = true;
  systemd.network.networks."10-eth" = {
    matchConfig.Name = "enp9s0";
    address = [ "10.1.100.20/22" ];
    gateway = [ "10.1.100.1" ];
    linkConfig.RequiredForOnline = "routable";
  };

  services.resolved = {
    enable = true;
    domains = [
      "patagia.net"
      "aarn.patagia.net"
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

  patagia = {
    desktop.enable = true;
    plymouth.enable = false;
    podman.enable = true;
  };

  environment.systemPackages = with pkgs; [
    ffado
    libcamera
    lact
    lm_sensors
    pam_rssh
    openconnect
    tpm2-tools
    v4l-utils
  ];

  programs.coolercontrol.enable = true;

  environment.variables = {
    OTEL_EXPORTER_OTLP_ENDPOINT = "https://otel.aarn.patagia.net";
  };

  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };

  users.users.dln = {
    isNormalUser = true;
    description = "Daniel Lundin";
    extraGroups = [
      "audio"
      "gamemode"
      "input"
      "render"
      "seat"
      "tss"
      "video"
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIIHMAEZx02kbHrEygyPQYStiXlrIe6EIqBCv7anIkL0pAAAABHNzaDo= dln@dinky"
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIJNOBFoU7Cdsgi4KpYRcv7EhR/8kD4DYjEZnwk6urRx7AAAABHNzaDo= dln@nemo"
    ];
  };

  users.users.lsjostro = {
    isNormalUser = true;
    description = "Lars Sjöström";
    extraGroups = [
      "tss"
      "wheel"
    ];
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

  nix.sshServe.enable = true;
  nix.sshServe.keys = [
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIIHMAEZx02kbHrEygyPQYStiXlrIe6EIqBCv7anIkL0pAAAABHNzaDo= dln@dinky"
    "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIJNOBFoU7Cdsgi4KpYRcv7EhR/8kD4DYjEZnwk6urRx7AAAABHNzaDo= dln@nemo"
    "sk-ecdsa-sha2-nistp256@openssh.com AAAAInNrLWVjZHNhLXNoYTItbmlzdHAyNTZAb3BlbnNzaC5jb20AAAAIbmlzdHAyNTYAAABBBJ10mLOpInoqDaySyrxbzvcOrJfLw48Y6eWHa9501lw+hEEBXya3ib7nlvpCqEQJ8aPU5fVRqpkOW5zSimCiRbwAAAAEc3NoOg=="
    "sk-ecdsa-sha2-nistp256@openssh.com AAAAInNrLWVjZHNhLXNoYTItbmlzdHAyNTZAb3BlbnNzaC5jb20AAAAIbmlzdHAyNTYAAABBBLpoKvsZDIQQLfgzJhe1jAQubBNxjydkj8UfdUPaSXqgfB02OypMOC1m5ZuJYcQIxox0I+4Z8xstFhYP6s8zKZwAAAAEc3NoOg=="
  ];

  nix.settings.trusted-users = [
    "dln"
    "lsjostro"
    "nixremote"
  ];

  services.printing.enable = lib.mkForce true;
  services.printing.drivers = [ pkgs.brlaser ];

  services.pipewire = {
    extraConfig = {
      pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 96000;
          "default.clock.quantum" = 1024;
          "default.clock.min-quantum" = 64;
          "default.clock.max-quantum" = 8192;
        };
      };

      pipewire-pulse."92-low-latency" = {
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "1024/96000";
              pulse.default.req = "1024/96000";
              pulse.max.req = "1024/96000";
              pulse.min.quantum = "1024/96000";
              pulse.max.quantum = "1024/96000";
            };
          }
        ];
        stream.properties = {
          node.latency = "1024/96000";
          resample.quality = 1;
        };
      };
    };

    wireplumber.extraConfig.main."99-alsa-lowlatency" = ''
      alsa_monitor.rules = {
        {
          matches = {{{ "node.name", "matches", "alsa_output.*" }}};
          apply_properties = {
            ["audio.format"] = "S32LE",
            ["audio.rate"] = "96000", -- for USB soundcards it should be twice your desired rate
            ["api.alsa.period-size"] = 2, -- defaults to 1024, tweak by trial-and-error
            -- ["api.alsa.disable-batch"] = true, -- generally, USB soundcards use the batch mode
          },
        },
      }
    '';

  };

  systemd.services.snapclient-kontoret = {
    enable = true;
    wantedBy = [ "pipewire.service" ];
    after = [ "pipewire.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.snapcast}/bin/snapclient --host 192.168.42.7 --hostID kontoret --soundcard sysdefault:CARD=AG06AG03";
    };
  };

  system.stateVersion = "24.11"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
}
