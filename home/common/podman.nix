{
  config,
  ...
}:
{

  # Storage configuration for Podman
  home.file.".config/containers/storage.conf".text = ''
    [storage]
    driver = "overlay"
    runroot = "${config.home.homeDirectory}/.local/share/containers/run"
    graphroot = "${config.home.homeDirectory}/.local/share/containers/storage"

    [storage.options]
    additionalimagestores = []

    [storage.options.overlay]
    mountopt = "nodev,metacopy=on"
  '';

}
