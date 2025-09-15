{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Excluding some GNOME applications from the default install
  environment.gnome.excludePackages = (
    with pkgs;
    [
      atomix # puzzle game
      baobab # disk usage analyzer
      cheese # webcam tool
      epiphany # web browser
      geary # email reader
      gnome-clocks
      gnome-connections
      gnome-disk-utility
      gnome-logs
      gnome-music
      gnome-photos
      gnome-terminal
      gnome-tour
      snapshot
      hitori # sudoku game
      iagno # go game
      simple-scan
      tali # poker game
      yelp # help viewer
    ]
  );

  services.desktopManager.gnome.enable = true;

  services.displayManager = {
    gdm.enable = true;
    gdm.autoSuspend = false;
  };

}
