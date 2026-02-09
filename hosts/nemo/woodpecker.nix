{
  pkgs,
  ...
}:
{

  users.users.woodpecker = {
    isSystemUser = true;
    group = "woodpecker";
    extraGroups = [
      "docker"
      "podman"
    ];
    createHome = true;
    home = "/etc/woodpecker";
    homeMode = "764";
  };
  users.groups.woodpecker = { };

  services.woodpecker-agents.agents.docker = {
    enable = true;
    package = pkgs.woodpecker-agent;
    environment = {
      DOCKER_HOST = "unix:///run/podman/podman.sock";
      WOODPECKER_BACKEND = "docker";
      WOODPECKER_SERVER = "10.1.100.10:8300"; # forgejo-1
      WOODPECKER_MAX_WORKFLOWS = "5";
      WOODPECKER_BACKEND_DOCKER_VOLUMES = "/etc/ssl/certs:/etc/ssl/certs:ro,/nix:/mnt/nix:ro,/var/lib/woodpecker-agent/nemo-patagia/cache:/cache";
    };
    environmentFile = [
      "/etc/woodpecker/woodpecker-agent.env"
    ];
    extraGroups = [ "podman" ];
  };

  systemd.services.woodpecker-agent-docker = {
    after = [
      "podman.socket"
      "woodpecker-server.service"
    ];
    # restartIfChanged = false;
    serviceConfig = {
      User = "woodpecker";
      Group = "woodpecker";
      WorkingDirectory = "/etc/woodpecker";
      BindPaths = [ "/run/podman/podman.sock" ];
    };
  };

}
