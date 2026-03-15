{ pkgs, ... }:
{
  home.packages = with pkgs; [
    age-plugin-fido2-hmac
    age-plugin-tpm
    bazelisk
    comma
    doggo
    file
    just
    nix-output-monitor
    openssl
  ];

  programs.distrobox.enable = true;
}
