{ pkgs, ... }:
{
  home.packages = with pkgs; [
    age-plugin-fido2-hmac
    bacon
    cargo
    clang
    codeium
    comma
    dogdns
    gnumake
    go
    just
    ldns
    minio-client
    nil
    nix-output-monitor
    nixd
    nixfmt-rfc-style
    nodejs_22
    passage
    rage
    prettierd
    rust-analyzer
    rustc
    stylua
    tree-sitter
  ];

  home.sessionVariables = {
    GOPROXY = "https://athena.patagia.dev";
  };
}
