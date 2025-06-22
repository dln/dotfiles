{ inputs, ... }:
{

  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
  };

  unstable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
    nixpkgs-unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
