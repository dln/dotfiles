{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";
      inputs = {
        nixpkgs-stable.follows = "nixpkgs";
        nixpkgs-unstable.follows = "nixpkgs";
      };
    };
    ghostty-hm.url = "github:clo4/ghostty-hm-module";
  };

  outputs =
    {
      self,
      nixpkgs,
      colmena,
      ghostty,
      ghostty-hm,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      mkHome =
        modules:
        home-manager.lib.homeManagerConfiguration {
          modules = [
            ghostty-hm.homeModules.default
            ./home/common
          ] ++ modules;
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };

      mkHost =
        modules:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          system = "x86_64-linux";
          modules = [ ./common ] ++ modules;
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
          default = pkgs.mkShell { packages = [ pkgs.colmena ]; };
        }
      );

      homeConfigurations = {
        "dln@dinky" = mkHome [ ./home/dln/dinky.nix ];
        "dln@nemo" = mkHome [ ./home/dln/nemo.nix ];
        "lsjostro@nemo" = mkHome [ ./home/lsjostro/nemo.nix ];
      };

      nixosConfigurations = {
        dinky = mkHost [ ./hosts/dinky ];
        nemo = mkHost [ ./hosts/nemo ];
      };

    };
}
