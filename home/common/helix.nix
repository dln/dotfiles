{
  pkgs,
  ...
}:
{

  xdg.configFile."vale/.vale.ini".text = ''
    MinAlertLevel = suggestion
    # StylesPath = styles
    # Packages = Google, write-good

    [asciidoctor]
    experimental = YES
    attribute-missing = drop

    [*.{adoc,md,rst}]
    BasedOnStyles = Vale
    #, Google, write-good
  '';

  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
      nixd
      nixfmt
      taplo
      asciidoctor
      vale
      (pkgs.hunspell.withDicts (dicts: [
        dicts.en_GB-ize
        dicts.en_US
        dicts.sv_SE
      ]))
      vscode-langservers-extracted
      typescript-language-server
      yaml-language-server
      typescript
      nodePackages.prettier
      bash-language-server
      marksman
      tinymist
      go
      gotools
      gopls
    ];
    defaultEditor = true;
    ignores = [
      "!.jj"
    ];
    languages = {

      grammar = [
        {
          name = "asciidoc";
          source = {
            git = "https://github.com/dln/tree-sitter-asciidoc.git";
            rev = "a89ef31e104c990cce9d203dd5430daec21036a9";
            subpath = "tree-sitter-asciidoc";
          };
        }
        {
          name = "asciidoc_inline";
          source = {
            git = "https://github.com/dln/tree-sitter-asciidoc.git";
            rev = "a89ef31e104c990cce9d203dd5430daec21036a9";
            subpath = "tree-sitter-asciidoc_inline";
          };
        }
      ];

      language-server.vale-ls.command = "${pkgs.vale-ls}/bin/vale-ls";
      language = [
        {
          name = "asciidoc";
          language-id = "asciidoc";
          language-servers = [ "vale-ls" ];
          scope = "source.adoc";
          injection-regex = "adoc";
          file-types = [ "adoc" ];
          comment-tokens = [ "//" ];
          block-comment-tokens = [
            {
              start = "////";
              end = "////";
            }
          ];
          grammar = "asciidoc";
        }
        {
          name = "asciidoc_inline";
          language-id = "asciidoc_inline";
          scope = "source.asciidoc_inline";
          injection-regex = "asciidoc_inline";
          file-types = [ ];
          comment-tokens = [ "//" ];
          block-comment-tokens = [
            {
              start = "////";
              end = "////";
            }
          ];
          grammar = "asciidoc_inline";
        }
        {
          name = "nix";
          formatter = {
            command = "${pkgs.nixfmt}/bin/nixfmt";
            args = [
              "--filename"
              "%{buffer_name}"
            ];
          };
          auto-format = true;
          language-servers = [ "nil" ];
        }
        {
          name = "rust";
          auto-format = true;
        }
        {
          name = "starlark";
          file-types = [
            "bzl"
            "bazel"
            "star"
            { glob = "BUILD"; }
            { glob = "BUILD.*"; }
            { glob = "WORKSPACE"; }
          ];
          formatter = {
            command = "buildifier";
            args = [ "-" ];
          };
          auto-format = true;
          language-servers = [ "starpls" ];
        }
      ];

    };
    settings = {
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
      keys.normal = {
        tab = [ "buffer_picker" ];
      };
      theme = "wolf-alabaster-light-bg";
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

  xdg.configFile."helix/themes/wolf-alabaster-dark.toml".source = builtins.fetchurl {
    url = "https://github.com/wolf/alabaster-for-helix/raw/refs/heads/main/helix/dot-config/helix/themes/wolf-alabaster-dark.toml";
    sha256 = "sha256:0l7d65nz2phhd19m89y0v466k859rvndlpx7rh7y8dpf2ajh6m7x";
  };

  xdg.configFile."helix/themes/wolf-alabaster-light.toml".source = builtins.fetchurl {
    url = "https://github.com/wolf/alabaster-for-helix/raw/refs/heads/main/helix/dot-config/helix/themes/wolf-alabaster-light.toml";
    sha256 = "sha256:1xdkcx2szf2w3ydg1alv444kkppczkc9kfbn0qgnzcqrcanigkqw";
  };

  xdg.configFile."helix/themes/wolf-alabaster-light-bg.toml".source = builtins.fetchurl {
    url = "https://github.com/wolf/alabaster-for-helix/raw/refs/heads/main/helix/dot-config/helix/themes/wolf-alabaster-light-bg.toml";
    sha256 = "sha256:1kh0aw6m18ijn6gcfzpfd9ddwwsr2kj5d108jpp6433l4jmwxm62";
  };
}
