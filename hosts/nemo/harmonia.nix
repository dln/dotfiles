{
  config,
  ...
}:
{

  age.secrets = {
    harmonia_signing_key = {
      # Public key: nix-cache.aarn.patagia.net:MInX1LGRR7eGZqmq16CXY6f7248kFpmRuw0hNs7yCos=
      file = ../../secrets/harmonia_signing_key.age;
      owner = "harmonia";
      group = "harmonia";
    };
  };

  services.harmonia = {
    enable = true;
    settings = {
      priority = 20;
    };
    signKeyPaths = [
      config.age.secrets.harmonia_signing_key.path
    ];
  };

  networking.firewall.allowedTCPPorts = [ 5000 ];
}
