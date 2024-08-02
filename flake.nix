{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      mkHome =
        modules:
        home-manager.lib.homeManagerConfiguration {
          modules = [ ./common ] ++ modules;
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };

      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      forEachSystem =
        f:
        builtins.listToAttrs (
          map (system: {
            name = system;
            value = f system;
          }) supportedSystems
        );
      systemBits = forEachSystem (system: rec {
        inherit system;
        pkgs = import nixpkgs {
          localSystem = system;
          overlays = [ ];
        };
      });

      forEachSystem' = f: forEachSystem (system: (f systemBits.${system}));
      inherit (nixpkgs) lib;
    in
    {
      overlays = import ./overlays { inherit inputs outputs; };

      devShells = forEachSystem' (
        { system, pkgs, ... }:
        {
          default = pkgs.mkShell { packages = [ pkgs.just ]; };
        }
      );

      homeConfigurations = {
        "dln@dinky" = mkHome [ ./users/dln/dinky.nix ];
        "dln@nemo" = mkHome [ ./users/dln/nemo.nix ];
        "lsjostro@nemo" = mkHome [ ./users/lsjostro/nemo.nix ];
      };

    };
}
