{ pkgs, ... }:
{
  home.packages = with pkgs; [
    age-plugin-fido2-hmac
    age-plugin-fido2-hmac
    age-plugin-tpm
    comma
    dogdns
    file
    just
    nix-output-monitor
    openssl
  ];

  home.sessionVariables = {
    GOPROXY = "https://athena.patagia.net";
  };
}
