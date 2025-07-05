{ pkgs, ... }:
{
  home.packages = with pkgs; [
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
