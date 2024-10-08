{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.patagia.desktop.enable {

    home.packages = with pkgs; [ tor-browser ];

    programs.firefox = {
      enable = true;
    };

    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
    };

  };
}
