{
  pkgs,
  ...
}:
{

  programs.helix = {
    enable = true;
    defaultEditor = true;
    ignores = [
      "!.jj"
    ];
    settings = {
      theme = "ayu_dark";
      editor = {
        auto-pairs = false;
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        cursorline = true;
        inline-diagnostics = {
          cursor-line = "hint";
        };

        popup-border = "all";
      };
    };

    themes.alabaster = {
      "ui.text" = "fg";
      "ui.text.focus".bg = "selected";
      "ui.linenr".fg = "fg_light";
      "ui.linenr.selected" = {
        bg = "bg";
        fg = "fg";
      };
      "ui.selection".bg = "selected";
      "ui.cursorline".bg = "bg_ui";
      "ui.statusline" = {
        fg = "status_bar_fg";
        bg = "status_bar_bg";
      };
      "ui.statusline.inactive" = {
        fg = "inact_status_bar_fg";
        bg = "inact_status_bar_bg";
      };
      "ui.virtual" = "indent";
      "ui.virtual.ruler".bg = "bg_ui";
      "ui.virtual.jump-label" = {
        fg = "fg";
        bg = "orange";
        modifiers = [ "bold" ];
      };
      "ui.cursor.match".bg = "bg_darker";
      "ui.cursor" = {
        bg = "cursor";
        fg = "white";
      };
      "ui.debug".fg = "orange";
      "ui.highlight.frameline".bg = "#da8581";
      "ui.help" = {
        fg = "fg";
        bg = "bg";
      };
      "ui.popup" = {
        fg = "fg";
        bg = "bg_ui";
      };
      "ui.menu" = {
        fg = "fg";
        bg = "bg_menu";
      };
      "ui.menu.selected".bg = "selected";
      "ui.window".bg = "bg_ui";
      "ui.bufferline" = {
        fg = "fg";
        bg = "bg";
      };
      "ui.bufferline.active" = {
        fg = "fg";
        bg = "bg";
      };

      "string" = "string";
      "comment" = "comment";
      "function" = "definitions";
      "constant" = "constants";
      "punctuation" = "punctuation";

      "error" = {
        fg = "red";
        bg = "bg_error";
      };
      "warning".fg = "orange";
      "hint" = {
        fg = "gray";
        bg = "bg_hint";
      };
      "diagnostic.error" = {
        fg = "red";
        bg = "bg_error";
        underline.style = "curl";
        modifiers = [ ];
      };
      "diagnostic.warning" = {
        bg = "orange";
        fg = "fg";
        modifiers = [ "bold" ];
      };
      "diagnostic.hint" = {
        fg = "gray";
        modifiers = [ "bold" ];
      };
      "diagnostic.unnecessary".modifiers = [ "dim" ];
      "diagnostic.deprecated".modifiers = [ "crossed_out" ];

      "diff.plus".fg = "green";
      "diff.delta".fg = "bg_ui";
      "diff.minus".fg = "red";

      palette = {
        white = "#ffffff";
        bg = "#f7f7f7";
        bg_darker = "#d0d0d0";
        bg_ui = "#eeeeee";
        bg_menu = "#d0d0d0d";
        bg_error = "#fff0f70";
        bg_hint = "#eeeeee";
        fg = "#000000";
        fg_light = "#9da39a";
        status_bar_bg = "#777777";
        status_bar_fg = "#f7f7f7";
        definitions = "#325CC0";
        constants = "#7A3E9D";
        punctuation = "#777777";
        inact_status_bar_bg = "#DDDDDD";
        inact_status_bar_fg = "#474747";
        comment = "#AA3731";
        string = "#448C27";
        selected = "#BFDBFE";
        cursor = "#444444";
        red = "#a0342f";
        green = "#065905";
        indent = "#aaaaaa";
        orange = "#f0ad4e";
        gray = "#777777";
      };
    };
  };
}
