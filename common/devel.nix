{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bacon
    cargo
    clang
    codeium
    gnumake
    go
    just
    ldns
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
