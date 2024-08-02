# NixOS Config

IT in a box!

## Bootstrapping from a fresh NixOS installation

1. Install NixOS
2. Clone this repo:

   ```
   nix-shell -p git --command 'git clone https://git.shelman.io/shelmangroup/nixos-config.git'
   ```

3. Ensure host configuration exists at `./nixos-config/hosts/${HOSTNAME}` and contains at minimum the hardware configuration. The NixOS installer will write this out to `/etc/nixos/hardware-configuration.nix`.
4. Apply configuration:
   ```
   sudo nixos-rebuild boot --flake ./nixos-config#${HOSTNAME}
   ```

## Use

1. Clone this repo somewhere convenient, like `~/src/shelman/nixos-config`
2. Apply configuration: `just switch`

## Update

Update nixpkgs and switch: `just update`

# Home Manager

`just home-switch`
