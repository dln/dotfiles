{
  pkgs,
  ...
}:
{

  programs.zellij = {
    enable = true;
    attachExistingSession = true;
    enableBashIntegration = true;
    enableFishIntegration = true;

    settings = {
      default_layout = "compact";
      pane_frames = false;
      show_startup_tips = false;
      ui.pane_frames = {
        hide_session_name = true;
      };
      plugins = {
        tab-bar.path = "tab-bar";
        status-bar.path = "status-bar";
        strider.path = "strider";
      };
      keybinds.normal = {
        "bind \"Alt 1\"" = {
          "GoToTab" = 1;
        };
        "bind \"Alt 2\"" = {
          "GoToTab" = 2;
        };
        "bind \"Alt 3\"" = {
          "GoToTab" = 3;
        };
        "bind \"Alt 4\"" = {
          "GoToTab" = 4;
        };
        "bind \"Alt 5\"" = {
          "GoToTab" = 5;
        };
        "bind \"Alt 6\"" = {
          "GoToTab" = 6;
        };
        "bind \"Alt 7\"" = {
          "GoToTab" = 7;
        };
        "bind \"Alt 8\"" = {
          "GoToTab" = 8;
        };
        "bind \"Alt 9\"" = {
          "GoToTab" = 9;
        };
        "bind \"Alt 0\"" = {
          "GoToTab" = 10;
        };
      };

    };
  };

}
