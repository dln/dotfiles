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
  };

  environment.variables = {
    AMD_VULKAN_ICD = "RADV";
    PROTON_ENABLE_HDR = "1";
    PROTON_ENABLE_WAYLAND = "1";
    PROTON_FSR4_UPGRADE = "1";
  };

  environment.systemPackages = with pkgs; [
    game-devices-udev-rules
    gamemode
  ];

}
