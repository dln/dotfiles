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
  imports = [
    ./hardware-configuration.nix
    ./apps.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];

  networking = {
    hostName = "pearl";
    domain = "aarn.patagia.dev";
    search = [
      "patagia.dev"
      "aarn.patagia.dev"
    ];
    useDHCP = lib.mkDefault true;
  };

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  time.timeZone = "Europe/Stockholm";

  users.users = {
    annso = {
      isNormalUser = true;
      description = "Ann-Sofie Stenberg";
      extraGroups = [
        "lp"
        "video"
        "audio"
        "wheel"
      ];
    };

    dln = {
      isNormalUser = true;
      description = "Daniel Lundin";
      extraGroups = [
        "lp"
        "wheel"
      ];
      openssh.authorizedKeys.keys = [
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAILwakA+EeuR23vRhjvjMkzK+FtWIhpnbs7z1pfnBehCUAAAABHNzaDo= dln@dinky"
        "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIJNOBFoU7Cdsgi4KpYRcv7EhR/8kD4DYjEZnwk6urRx7AAAABHNzaDo= dln@nemo"
      ];
    };
  };

  patagia = {
    desktop.enable = true;
    laptop.enable = true;
    plymouth.enable = true;
    podman.enable = false;
  };

  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "se";
    # variant = "us";
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}
