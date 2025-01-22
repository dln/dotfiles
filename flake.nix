{
  description = "NixOS configuration";

  nixConfig = {
    substituters = [
      "https://cache-nixos-org.aarn.patagia.net/"
    ];
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    ghostty.url = "github:ghostty-org/ghostty";
    jujutsu.url = "github:dln/jj/openssh";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-index-database,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

      mkHost =
        modules:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./common ] ++ modules;
        };

      mkHome =
        modules:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs-unstable.legacyPackages.${system};
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./home/common
            nix-index-database.hmModules.nix-index
          ] ++ modules;
        };
    in
    {
      overlays = import ./overlays { inherit inputs outputs; };

      devShell.${system} = pkgs.mkShell {
        packages = with pkgs; [
          just
          nh
          nil
          nixd
          nixfmt-rfc-style
        ];
      };

      nixosConfigurations = {
        dinky = mkHost [ ./hosts/dinky ];
        nemo = mkHost [ ./hosts/nemo ];
        pearl = mkHost [ ./hosts/pearl ];
      };

      homeConfigurations = {
        "dln@dinky" = mkHome [ ./home/dln/dinky.nix ];
        "dln@nemo" = mkHome [ ./home/dln/nemo.nix ];
        "dln@pearl" = mkHome [ ./home/dln/pearl.nix ];
      };
    };
}
