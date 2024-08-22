{ pkgs, ... }:
{
  home.packages = with pkgs; [
    age-plugin-fido2-hmac
    bacon
    cargo
    clang
    codeium
    gnumake
    go
    just
    ldns
    minio-client
    nixfmt-rfc-style
    nodejs_22
    passage
    rage
    prettierd
    rust-analyzer
    rustc
    sqlite
    stylua
    tree-sitter
    zig
  ];
}
