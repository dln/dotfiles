{ pkgs, ... }:
{
  imports = [
    ./home.nix
    ./desktop.nix
  ];

  patagia = {
    laptop.enable = true;
    oled.enable = true;
  };

  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [ "Battery-Health-Charging@maniacx.github.com" ];
    };
  };

  home.packages = with pkgs; [ ];

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  xdg.desktopEntries = {
    ghostty-devel = {
      categories = [
        "System"
        "TerminalEmulator"
      ];
      exec = ''
        ghostty --class=com.mitchellh.ghostty-devel --command="ssh -t devel" --initial-command="ssh -t devel"
      '';
      genericName = "Ghostty (devel)";
      icon = "com.mitchellh.ghostty";
      name = "Ghostty (devel)";
      settings = {
        StartupWMClass = "com.mitchellh.ghostty-devel";
        TryExec = "ghostty";
      };
      terminal = false;
      type = "Application";
    };

    ghostty-devel-secondary = {
      categories = [
        "System"
        "TerminalEmulator"
      ];
      exec = ''
        ghostty --class=com.mitchellh.ghostty-devel-secondary --background-opacity=0.8 --font-style="ExtraCondensed" --font-style-bold="Bold ExtraCondensed" --font-style-italic="ExtraCondensed Oblique" --command="ssh -t devel" --initial-command="ssh -t devel"
      '';
      genericName = "Secondary Ghostty (devel)";
      icon = "com.mitchellh.ghostty";
      name = "Secondary Ghostty (devel)";
      settings = {
        StartupWMClass = "com.mitchellh.ghostty-devel-secondary";
        TryExec = "ghostty";
      };
      terminal = false;
      type = "Application";
    };
  };
}
