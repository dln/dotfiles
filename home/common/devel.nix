{ pkgs, ... }:
{
  home.packages = with pkgs; [
    age-plugin-fido2-hmac
    age-plugin-fido2-hmac
    age-plugin-tpm
    comma
    doggo
    file
    just
    nix-output-monitor
    openssl
  ];

  programs.distrobox.enable = true;

  home.sessionVariables = {
    GOPROXY = "https://athena.patagia.net";
  };
}
