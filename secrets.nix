let
  dln_dinky = "age1tpm1qtzft9rjkcprk76yd6syxrskezlkafzfanadmlcp03at8fk6a6f27ygky9e";
  dln_nemo = "age1tpm1q0jdt4w7r7k2xdwxcxjzkqrfmtesryd2x83pz3lqr335v7mleyn8jn9z7hs";
  destinations = [
    dln_dinky
    dln_nemo
  ];
in
{
  "secrets/codestral_api_key.age".publicKeys = destinations;
}
