{
  config,
  pkgs,
  ...
}:
{

  age = {
    package = pkgs.writeShellScriptBin "age-with-plugins" ''
      exec env PATH="${pkgs.lib.makeBinPath [ pkgs.age-plugin-tpm ]}" ${pkgs.lib.getExe pkgs.age} "$@"
    '';

    identityPaths = [
      "${config.home.homeDirectory}/.age/id-dotfiles"
    ];
  };
}
