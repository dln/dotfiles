{ pkgs, ... }:
{
  patagia = {
    desktop.enable = true;
  };

  home.packages = with pkgs; [
    cameractrls-gtk4
    dynamic-wallpaper
    gimp3-with-plugins
    inkscape
    libreoffice
    moonlight-qt
    obsidian
    pavucontrol
    plexamp
    (symlinkJoin {
      name = "signal-desktop";
      paths = [ signal-desktop ];
      nativeBuildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram "$out/bin/signal-desktop" \
          --add-flags '--password-store="gnome-libsecret"'
      '';
    })
    thunderbird
  ];

  xdg.desktopEntries = {
    firefox-work = {
      categories = [
        "Network"
        "WebBrowser"
      ];
      comment = "Browse the Web";
      exec = "firefox %u -P work --new-instance --name firefox-work";
      genericName = "Web Browser";
      icon = "firefox";
      mimeType = [
        "text/html"
        "text/xml"
        "application/xhtml+xml"
        "application/vnd.mozilla.xul+xml"
        "text/mml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ];
      name = "Firefox (Work)";
      settings = {
        StartupWMClass = "firefox-work";
        Keywords = "web;browser;internet";
      };
      terminal = false;
      type = "Application";
    };
  };
}
