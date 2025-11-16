{
  pkgs,
  ...
}:
{

  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
    extraPackages = with pkgs; [
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
    ];
    extraCompatPackages = with pkgs; [
      proton-ge-bin
      vulkan-loader
    ];
  };

  environment.systemPackages = with pkgs; [
    game-devices-udev-rules
    gamemode
  ];

}
