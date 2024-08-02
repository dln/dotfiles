{ outputs, ... }:
{
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
