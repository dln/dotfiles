{ inputs, ... }:
{

  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
  };

  unstable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
    nixpkgs-unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;
      config.allowUnfree = true;
    };
  };
}
