{
  pkgs,
  ...
}:
{

  programs.gamemode = {
    enable = true;
    enableRenice = true;
    settings = {
      general = {
        renice = 10;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 1;
        amd_performance_level = "high";
      };
    };
  };

  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      vulkan-loader
    ];
  };

  environment.variables = {
    # AMD_VULKAN_ICD = "RADV";
    DXVK_HDR = "1";
    ENABLE_HDR_WSI = "1";
    PROTON_ENABLE_HDR = "1";
    PROTON_ENABLE_WAYLAND = "1";
    PROTON_FSR4_UPGRADE = "1";
    # SDL_VIDEODRIVER = "wayland";
    # STEAM_MULTIPLE_XWAYLANDS = "1";

    # VKD3D_SWAPCHAIN_LATENCY_FRAMES = "3";
    # WINE_CPU_TOPOLOGY = "8:0,1,2,3,4,5,6,7";
    # WINEDLLOVERRIDES = "dxgi=n";
    XDG_SEAT = "seat1";
  };

  environment.systemPackages = with pkgs; [
    game-devices-udev-rules
    gamemode
  ];

  services.seatd = {
    enable = true;
    group = "seat";
  };

  # Multiseat Configuration
  services.udev.extraRules = ''
    SUBSYSTEM=="tty", KERNEL=="tty8", TAG+="seat", ENV{ID_SEAT}="seat1"

    # Grant render group access to DRM devices
    SUBSYSTEM=="drm", GROUP="video", MODE="0666"
    KERNEL=="renderD*", GROUP="render", MODE="0666"
    KERNEL=="card1", GROUP="video", MODE="0666"

    # Specific permissions for card1 (discrete GPU)
    KERNEL=="card1", GROUP="video", MODE="0666"
    KERNEL=="renderD128", GROUP="render", MODE="0666"

    # USB permissions for Xbox Wireless Adapter
    SUBSYSTEM=="usb", ATTRS{idVendor}=="045e", ATTRS{idProduct}=="02e6", MODE="0666", GROUP="input"

    # Xbox Wireless Adapter udev rules for xone driver
    # SUBSYSTEM=="input", ATTRS{name}=="Xbox Wireless Controller", TAG+="seat", ENV{ID_SEAT}="seat1"
    # SUBSYSTEM=="input", ATTRS{name}=="Microsoft X-Box One*", TAG+="seat", ENV{ID_SEAT}="seat1"

    # Seat assignment
    TAG=="seat", ENV{ID_FOR_SEAT}=="drm-pci-0000_03_00_0",  ENV{ID_SEAT}="seat1"
    TAG=="seat", ENV{ID_FOR_SEAT}=="graphics-pci-0000_03_00_0", ENV{ID_SEAT}="seat1"
    TAG=="seat", ENV{ID_FOR_SEAT}=="sound-pci-0000_03_00_1", ENV{ID_SEAT}="seat1"
    # Microsoft Corp. Xbox Wireless Adapter for Windows
    TAG=="seat", ENV{ID_FOR_SEAT}=="usb-pci-0000_00_14_0-usb-0_5_4", ENV{ID_SEAT}="seat1"
    # Logitech k400 wireless keyboard
    TAG=="seat", ENV{ID_FOR_SEAT}=="usb-pci-0000_00_14_0-usb-0_9", ENV{ID_SEAT}="seat1"
  '';

  # User Configuration
  users.users.gamer = {
    isNormalUser = true;
    home = "/games/gamer";
    uid = 1003;
    linger = true;
    extraGroups = [
      "wheel"
      "audio"
      "render"
      "video"
      "input"
      "gamemode"
      "seat"
    ];
  };

  systemd.user.services.steam = {
    description = "Steam Client";

    unitConfig = {
      After = "graphical-session.target";
      PartOf = "graphical-session.target";
      ConditionUser = "gamer"; # Only run for the 'gamer' user
    };

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.steam}/bin/steam -gamepadui";
      Restart = "always";
      RestartSec = 5;
      Environment = [
        "WAYLAND_DISPLAY=wayland-0"
        "XDG_SESSION_TYPE=wayland"
      ];
    };

    wantedBy = [ "default.target" ];
  };

}
