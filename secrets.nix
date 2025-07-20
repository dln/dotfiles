let
  hosts = {
    nemo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPRXR6s+TbdGbr5fNHzDJZT2fO3PuJ8H84tBeiIZsaTe";
  };

  commonKeys = [
    "age15qx6tmxcwcpmy8m082rp52zdg4j06j48nlw8vjj2uvqflc5665uqum3cld" # dln@dinky (nitrokey 3a mini)
    "age1cyadjx9trs24wtk9yd6v0vlkeraw7sadk2py63hlxgjau3cdr46qkasw5n" # dln@nemo  (yubikey 5c nano)
    dln_dinky
    dln_nemo
  ];

  dln_dinky = "age1tpm1qtzft9rjkcprk76yd6syxrskezlkafzfanadmlcp03at8fk6a6f27ygky9e";
  dln_nemo = "age1tpm1q0jdt4w7r7k2xdwxcxjzkqrfmtesryd2x83pz3lqr335v7mleyn8jn9z7hs";

  secrets = {
    "codestral_api_key" = [ ];
    "harmonia_signing_key" = [ hosts.nemo ];
  };
in

builtins.listToAttrs (
  map (secretName: {
    name = "secrets/${secretName}.age";
    value.publicKeys = secrets."${secretName}" ++ commonKeys;
  }) (builtins.attrNames secrets)
)
