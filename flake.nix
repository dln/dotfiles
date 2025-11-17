{
  description = "NixOS configuration";

  inputs = {
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay?shallow=true";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05?shallow=true";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable?shallow=true";

    nix-index-database.url = "github:nix-community/nix-index-database?shallow=true";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ragenix.url = "github:yaxitech/ragenix";
    run0-sudo-shim.url = "github:lordgrimmauld/run0-sudo-shim";
    run0-sudo-shim.inputs.nixpkgs.follows = "nixpkgs";

    zjstatus.url = "github:dj95/zjstatus";
  };

  outputs =
    inputs@{
      self,
      nix-index-database,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      ragenix,
      zjstatus,
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
          modules = [
            ragenix.nixosModules.default
            inputs.run0-sudo-shim.nixosModules.default
            ./common
          ]
          ++ modules;
        };

      mkHome =
        modules:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ragenix.homeManagerModules.default
            ./home/common
            nix-index-database.homeModules.nix-index
          ]
          ++ modules;
        };
    in
    {
      overlays = import ./overlays { inherit inputs outputs; };

      devShell.${system} = pkgs.mkShell {
        packages = with pkgs; [
          age-plugin-tpm
          just
          lua-language-server
          nh
          nil
          nixd
          nixfmt-rfc-style
          (inputs.ragenix.packages.${system}.default.override { plugins = [ age-plugin-tpm ]; })
          rage
        ];
      };

      nixosConfigurations = {
        dinky = mkHost [ ./hosts/dinky ];
        nemo = mkHost [ ./hosts/nemo ];
      };

      homeConfigurations = {
        "dln@dinky" = mkHome [ ./home/dln/dinky.nix ];
        "dln@nemo" = mkHome [ ./home/dln/nemo.nix ];
      };
    };
}
