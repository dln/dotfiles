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
        gpu_device = 0;
        amd_performance_level = "high";
      };
    };
  };

  jovian = {
    steam = {
      enable = true;
      autoStart = false; # Don't auto-start on boot
      user = "gamer";
      environment = {
        DXVK_HDR = "1";
        ENABLE_GAMESCOPE_WSI = "1";
        ENABLE_HDR_WSI = "0";
        PROTON_FSR4_UPGRADE = "1";
        STEAM_MULTIPLE_XWAYLANDS = "1";
      };
    };
    decky-loader.enable = false; # Disable for now
  };

  programs.gamescope = {
    enable = true;
    # capSysNice = true;
    env = {
      DXVK_HDR = "1";
      ENABLE_GAMESCOPE_WSI = "1";
      ENABLE_HDR_WSI = "0";
      PROTON_FSR4_UPGRADE = "1";
      STEAM_MULTIPLE_XWAYLANDS = "1";
    };
  };

  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
    extraPackages = with pkgs; [
      gamescope
      gamescope-wsi
      xorg.libXcursor
      xorg.libXi
      xorg.libXinerama
      xorg.libXScrnSaver
      libpng
      libpulseaudio
      libvorbis
      stdenv.cc.cc.lib
      libkrb5
      keyutils
      # Where gamescope-session looks for "Exit to Desktop" when -steamos3 is provided
      (writeShellScriptBin "steamos-session-select" ''
        /usr/bin/env steam -shutdown
      '')
      (writeScriptBin "steamos-polkit-helpers/steamos-update" ''
        #!${pkgs.stdenv.shell}
        exit 7
      '')
    ];
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      gamescope-wsi
      vulkan-loader
    ];
    gamescopeSession = {
      args = [
        "--adaptive-sync"
        "--hdr-enabled"
        "--hdr-itm-enable"
        "--hdr-itm-target-nits"
        "700"
        "--hdr-itm-sdr-nits"
        "300"
        "--hdr-sdr-content-nits"
        "300"
        "--prefer-vk-device"
        "1002:7550"
        "--fullscreen"
        "-O"
        "DP-2"
        "--xwayland-count 2"
        "-w"
        "3840"
        "-h"
        "2160"
        "-W"
        "3840"
        "-H"
        "2160"
        "-r"
        "120"
      ];
      enable = true;
      env = {
        DXVK_HDR = "1";
        ENABLE_GAMESCOPE_WSI = "1";
        ENABLE_HDR_WSI = "0";
        PROTON_FSR4_UPGRADE = "1";
        STEAM_MULTIPLE_XWAYLANDS = "1";
        STEAM_GAMESCOPE_VRR_SUPPORTED = "1";

        STEAM_DISABLE_AUDIO_DEVICE_SWITCHING = "1";
        STEAM_GAMESCOPE_DYNAMIC_FPSLIMITER = "1";
        STEAM_GAMESCOPE_HAS_TEARING_SUPPORT = "1";
        STEAM_GAMESCOPE_TEARING_SUPPORTED = "1";
        STEAM_GAMESCOPE_FANCY_SCALING_SUPPORT = "1";
        STEAM_GAMESCOPE_COLOR_MANAGED = "1";
        STEAM_GAMESCOPE_VIRTUAL_WHITE = "1";
        STEAM_ENABLE_CEC = "1";
        GAMESCOPE_NV12_COLORSPACE = "k_EStreamColorspace_BT601";
        STEAM_GAMESCOPE_HDR_SUPPORTED = "1";
        VKD3D_SWAPCHAIN_LATENCY_FRAMES = "3";
        WINE_CPU_TOPOLOGY = "8:0,1,2,3,4,5,6,7";
        WINEDLLOVERRIDES = "dxgi=n";
      };
    };
  };

  environment.variables = {
    AMD_VULKAN_ICD = "RADV";
    PROTON_FSR4_UPGRADE = "1";
    STEAM_ENABLE_CEC = "1";
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
    # TAG=="seat", ENV{ID_FOR_SEAT}=="drm-pci-0000_03_00_0", ENV{ID_SEAT}="seat1"
    # TAG=="seat", ENV{ID_FOR_SEAT}=="graphics-pci-0000_03_00_0", ENV{ID_SEAT}="seat1"
    # TAG=="seat", ENV{ID_FOR_SEAT}=="sound-pci-0000_03_00_1", ENV{ID_SEAT}="seat1"
  '';

  # User Configuration
  users.users.gamer = {
    isNormalUser = true;
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

  systemd.services.gaming = {
    enable = false;

    description = "Gamescope Session on seat1";
    after = [
      "graphical-session.target"
      "user@1003.service"
    ];
    wants = [ "user@1003.service" ];
    wantedBy = [ "multi-user.target" ];

    environment = {
      DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/1003/bus";
      DRM_DEVICE = "/dev/dri/card1";
      WLR_DRM_DEVICES = "/dev/dri/card1";
      WLR_DRM_NO_ATOMIC = "1";
      DXVK_HDR = "1";
      HOME = "/home/gamer";
      USER = "gamer";
      XDG_RUNTIME_DIR = "/run/user/1003";
      # XDG_SEAT = "seat1";
    };

    serviceConfig = {
      Type = "simple";
      User = "gamer";
      Group = "video";
      SupplementaryGroups = [
        "render"
        "input"
        "audio"
        "seat"
      ];
      # ExecStart = "/run/current-system/sw/bin/start-gamescope-session";
      ExecStart = "/run/current-system/sw/bin/steam-gamescope";
      Restart = "always";
      RestartSec = 10;
      RuntimeDirectory = "user-1003";
      RuntimeDirectoryMode = "0755";
      PAMName = "login";
      TTYPath = "/dev/tty8";
      TTYReset = "yes";
      TTYVHangup = "yes";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
    };
  };

}
