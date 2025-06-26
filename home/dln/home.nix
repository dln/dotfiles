{
  config,
  lib,
  pkgs,
  ...
}:
let
  realName = "Daniel Lundin";
  email = "dln@arity.se";
in
{
  home = {
    username = "dln";
    homeDirectory = "/home/dln";
    packages = with pkgs; [
      asciinema
      ouch
      toolbox
    ];
  };

  programs.atuin.settings = {
    show_tabs = false;

    cwd_filter = [
      "^~/media"
      "^/home/dln/media"
      "^/tmp"
    ];

    history_filter = [
      "^kubectl create secret.*--from-literal"
      "^kubectl delete ns"
      "^kubectl delete namespace"
      "^talosctl reset"
    ];
  };

  programs.git = {
    userName = realName;
    userEmail = email;
  };

  programs.helix = {
    enable = true;
  };

  programs.jujutsu = {
    settings = {
      user = {
        email = email;
        name = realName;
      };

      signing = {
        behavior = "own";
        backend = "ssh";
        backends.ssh.allowed-signers = "/home/dln/.ssh/authorized_keys";
        key = "/home/dln/.ssh/git_signing_key.pub";
      };

      git = {
        push-bookmark-prefix = "dln/push-";
      };

      ui = {
        "default-command" = [ "s" ];
        pager = "delta";
      };

      "merge-tools" = {
        diffconflicts = {
          program = "nvim";
          merge-args = [
            "-c"
            "let g:jj_diffconflicts_marker_length=$marker_length"
            "-c"
            "JJDiffConflicts!"
            "$output"
            "$base"
            "$left"
            "$right"
          ];
          merge-tool-edits-conflict-markers = true;
        };
        difft."diff-args" = [
          "--color=always"
          "$left"
          "$right"
        ];
        difftu = {
          program = "difft";
          "diff-args" = [
            "--color=always"
            "--display=inline"
            "$left"
            "$right"
          ];
        };
      };

      aliases = {
        l = [
          "log"
          "--limit=25"
          "-T"
          "builtin_log_comfortable"
          "-r"
          "(main..@) | (main..@)-"
        ];
        la = [
          "log"
          "--limit=25"
          "-T"
          "builtin_log_oneline"
          "-r"
          "all()"
        ];
        d = [
          "diff"
          "--tool=difft"
        ];
        dd = [
          "diff"
          "--git"
        ];
        du = [
          "diff"
          "--tool=difftu"
        ];
        s = [
          "util"
          "exec"
          "--"
          "bash"
          "-c"
          ''
            #!/usr/bin/env bash
            set -eo pipefail
            printf '\e[38;5;240m\u2504%.0s\e[0m' $(seq 1 $(tput cols)) '\n'
            jj show --stat
            printf '\e[38;5;240m\u2504%.0s\e[0m' $(seq 1 $(tput cols)) '\n'
            if [ -n "$1" ]; then
              jj diff --tool=difft -r "$@"
            else
              jj log --limit=15 -T builtin_log_comfortable
            fi
          ''
          ""
        ];
      };

      "revset-aliases" = {
        # Prevent rewriting commits on main@origin and commits authored by other users;
        "user(x)" = "author(x) | committer(x)";
        "trunk()" = "latest((present(main) | present(master)) & remote_bookmarks())";
        "open" = "(mine() ~ ::trunk()) ~ heads(empty())";
        "wip" = ''description("wip: ")'';
        "ready" = "open() ~ (wip::)";
      };

      colors =
        let
          bold = {
            bold = true;
          };
          dim = {
            fg = "bright black";
          };
          underline = {
            fg = "default";
            underline = true;
          };
        in
        {
          "error" = bold;
          "warning" = bold;
          "error heading" = bold;
          "error_source heading" = bold;
          "warning heading" = bold;
          "hint heading" = bold;
          "prefix" = bold;
          "rest" = "bright black";
          "divergent prefix" = underline;
          "bookmark" = "bright magenta";
          "bookmarks" = "bright magenta";
          "change_id" = "bright magenta";
          "local_bookmarks" = "bright magenta";

          "diff file_header" = bold;
          "diff hunk_header" = "cyan";
          "diff removed" = "red";
          "diff removed token" = "red";
          "diff added" = "green";
          "diff added token" = "green";
          "diff modified" = "cyan";
          "diff untracked" = "blue";
          "diff renamed" = "cyan";
          "diff copied" = "green";
          "diff access-denied" = {
            bg = "red";
          };

          "empty" = "green";
          "elided" = "blue";
          "node elided" = dim;
          "node working_copy" = {
            fg = "green";
            bold = true;
          };
          "node current_operation" = bold;
          "node immutable" = bold;
          "node conflict" = {
            fg = "red";
            bold = true;
          };
          "operation id" = "blue";
          "operation current_operation" = bold;
          "remote_bookmarks" = "bright magenta";
          "working_copy" = {
            fg = "green";
            bold = true;
          };
          "working_copy empty" = {
            fg = "green";
            bold = true;
          };
          "working_copy change_id" = "bright magenta";
          "working_copy description placeholder" = "green";
          "working_copy empty description placeholder" = "green";
          "working_copy bookmark" = "bright magenta";
          "working_copy bookmarks" = "bright magenta";
          "working_copy local_bookmarks" = "bright magenta";
          "working_copy remote_bookmarks" = "bright magenta";
        }
        // lib.genAttrs [
          "author"
          "branch"
          "branches"
          "commit_id"
          "committer"
          "config_list name"
          "config_list overridden"
          "config_list overridden name"
          "config_list overridden value"
          "config_list value"
          "conflict"
          "conflict_description"
          "conflict_description difficult"
          "description placeholder"
          "diff token"
          "divergent"
          "divergent change_id"
          "divergent rest"
          "empty description placeholder"
          "error_source"
          "git_head"
          "git_refs"
          "hidden prefix"
          "hint"
          "local_branches"
          "operation current_operation id"
          "operation current_operation time"
          "operation current_operation user"
          "operation time"
          "operation user"
          "placeholder"
          "remote_branches"
          "root"
          "separator"
          "tag"
          "tags"
          "timestamp"
          "working_copies"
          "working_copy author"
          "working_copy branch"
          "working_copy branches"
          "working_copy commit_id"
          "working_copy committer"
          "working_copy conflict"
          "working_copy divergent"
          "working_copy divergent change_id"
          "working_copy git_refs"
          "working_copy local_branches"
          "working_copy placeholder"
          "working_copy remote_branches"
          "working_copy tag"
          "working_copy tags"
          "working_copy timestamp"
          "working_copy working_copies"
        ] (_: "default");

    };
  };

  programs.ssh.extraConfig = ''
    Include ${config.home.homeDirectory}/.ssh/config_local
  '';

  programs.ssh.matchBlocks = {
    dev-old = {
      hostname = "10.1.100.16";
      forwardAgent = true;
    };

    devel = {
      hostname = "10.1.100.20";
      forwardAgent = true;
      localForwards = [
        {
          bind.address = "localhost";
          bind.port = 8000;
          host.address = "localhost";
          host.port = 8000;
        }
        {
          bind.address = "localhost";
          bind.port = 8080;
          host.address = "localhost";
          host.port = 8080;
        }
        {
          bind.address = "localhost";
          bind.port = 8484;
          host.address = "localhost";
          host.port = 8484;
        }
      ];
    };
  };

  services.syncthing.enable = true;

  home.stateVersion = "24.05"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
}
