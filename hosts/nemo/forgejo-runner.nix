{
  config,
  pkgs,
  ...
}:
{
  age.secrets.forgejo_runner_token_nemo.file = ../../secrets/forgejo_runner_token_nemo.age;

  services.gitea-actions-runner = {
    package = pkgs.forgejo-runner;
    instances = {
      nemo = {
        enable = true;
        url = "https://patagia.dev";
        name = "nemo";
        labels = [
          "docker:docker://data.forgejo.org/oci/node:22-bookworm"
          "nixos-latest:docker://nixos/nix"
          "ubuntu-latest:docker://node:22-bookworm"
        ];
        tokenFile = config.age.secrets.forgejo_runner_token_nemo.path;
        settings = {
          capacity = 4;
          # container.network = "host";
          cache.enabled = true;
        };
      };
    };
  };

}
