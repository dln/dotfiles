{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.patagia.desktop.enable {

    gtk = {
      enable = true;
      theme.name = "Arc-Dark";
      iconTheme.package = pkgs.adwaita-icon-theme;
      iconTheme.name = "Adwaita";

      gtk2.extraConfig = ''
        gtk-cursor-theme-name="Adwaita"
        gtk-cursor-theme-size=24
        gtk-application-prefer-dark-theme=1
      '';
      gtk3.extraConfig = {
        "gtk-cursor-theme-name" = "Adwaita";
        "gtk-cursor-theme-size" = 24;
        "gtk-application-prefer-dark-theme" = 1;
      };
      gtk4.extraConfig = {
        "gtk-cursor-theme-name" = "Adwaita";
        "gtk-cursor-theme-size" = 24;
      };
    };

    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          "color-scheme" = "prefer-dark";
          "gtk-enable-primary-paste" = false;
        };
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };

  };
}
