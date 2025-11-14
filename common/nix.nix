{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in
    {
      settings = {
        auto-optimise-store = true;
        experimental-features = "nix-command flakes";
        flake-registry = "";
        substituters = [
          "https://nix.aarn.patagia.net?priority=1"
          "https://nix-community.cachix.org?priority=2"
          # "https://cache.nixos.org/"
        ];
        trusted-public-keys = [
          "nix.aarn.patagia.net:SQs7heV/yoZ8wb6G9eEKF09xaOvS+G4ezN0xojtCfhU="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          # "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        ];
      };

      channel.enable = false;
      registry = lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
    config.allowUnfree = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = false;
    clean.extraArgs = "--keep-since 14d --keep 5";
  };
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    nvd
  ];
}
