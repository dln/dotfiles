{ inputs, ... }:
{

  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {

    # https://discourse.nixos.org/t/disable-ssh-agent-from-gnome-keyring-on-gnome/28176/5
    gnome-keyring = prev.gnome-keyring.overrideAttrs (oldAttrs: {
      mesonFlags = (builtins.filter (flag: flag != "-Dssh-agent=true") oldAttrs.mesonFlags) ++ [
        "-Dssh-agent=false"
      ];
    });
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
