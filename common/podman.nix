{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.patagia.podman;
in
{
  options.patagia.podman.enable = mkEnableOption "Podman";

  config = mkIf cfg.enable {
    environment.extraInit = ''
      if [ -z "$DOCKER_HOST" -a -n "$XDG_RUNTIME_DIR" ]; then
        export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"
      fi
    '';

    environment.systemPackages = with pkgs; [
      docker-compose
      podman-compose
    ];

    virtualisation = {
      containers = {
        enable = true;
        storage.settings = {
          storage = {
            driver = "overlay";
            runroot = "/run/containers/storage";
            graphroot = "/var/lib/containers/storage";
            rootless_storage_path = "/tmp/containers-$USER";
            options.overlay.mountopt = "nodev,metacopy=on";
          };
        };
      };

      oci-containers.backend = "podman";
      podman = {
        enable = true;
        dockerCompat = true;
      };
    };
  };
}
