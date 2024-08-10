{ inputs, pkgs, ... }:
{
  shelman = {
    desktop.enable = true;
  };

  home.packages = with pkgs; [
    audacity
    bitwig-studio
    dynamic-wallpaper
    gimp-with-plugins
    helvum
    inkscape
    inputs.ghostty.packages.${pkgs.system}.default
    moonlight-qt
    obsidian
    pavucontrol
    plexamp
    reaper
    signal-desktop
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

    wezterm-nemo = {
      categories = [
        "System"
        "TerminalEmulator"
      ];
      exec = "wezterm start --class=org.wezfurlong.wezterm-nemo --domain=nemo";
      genericName = "wezterm-nemo";
      icon = "org.wezfurlong.wezterm";
      name = "wezterm-nemo";
      settings = {
        StartupWMClass = "org.wezfurlong.wezterm-nemo";
        TryExec = "wezterm";
      };
      terminal = false;
      type = "Application";
    };
  };
}
