{
  description = "NixOS configuration";

  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-unstable";

    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";
      inputs = {
        nixpkgs-stable.follows = "nixpkgs-stable";
        nixpkgs-unstable.follows = "nixpkgs-unstable";
      };
    };
    ghostty-hm.url = "github:clo4/ghostty-hm-module";
  };

  outputs =
    inputs@{
      self,
      nixpkgs-unstable,
      ghostty-hm,
      home-manager,
      ...
    }:
    let
      inherit (self) outputs;
      system = "x86_64-linux";
      pkgs = nixpkgs-unstable.legacyPackages.${system};

      mkHost =
        modules:
        nixpkgs-unstable.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./common ] ++ modules;
        };

      mkHome =
        modules:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ghostty-hm.homeModules.default
            ./home/common
          ] ++ modules;
        };
    in
    {
      overlays = import ./overlays { inherit inputs outputs; };

      devShell.${system} = pkgs.mkShell {
        packages = with pkgs; [
          just
          nh
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
        "lsjostro@nemo" = mkHome [ ./home/lsjostro/nemo.nix ];
      };
    };
}
