{
  config,
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [
    age-plugin-fido2-hmac
    age-plugin-tpm
    passage
    rage
  ];

  age = {
    package = pkgs.writeShellScriptBin "age-with-plugins" ''
      exec env PATH="${pkgs.lib.makeBinPath [ pkgs.age-plugin-tpm ]}" ${pkgs.lib.getExe pkgs.age} "$@"
    '';

    identityPaths = [
      "${config.home.homeDirectory}/.age/id-dotfiles"
    ];
  };
}
