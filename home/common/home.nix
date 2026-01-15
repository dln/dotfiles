{
  pkgs,
  ...
}:
{
  home = {
    username = "dln";
    homeDirectory = "/home/dln";
    language = {
      base = "en_US.UTF-8";
      measurement = "sv_SE.UTF-8";
      monetary = "sv_SE.UTF-8";
      numeric = "sv_SE.UTF-8";
      paper = "sv_SE.UTF-8";
      telephone = "sv_SE.UTF-8";
      time = "sv_SE.UTF-8";
    };
    packages = with pkgs; [
      asciinema
      ouch
      toolbox
    ];
  };

  home.stateVersion = "25.05"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
}
