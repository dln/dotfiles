{
  config,
  lib,
  ...
}:
{
  programs.git.settings = {
    user.name = "Daniel Lundin";
    user.email = "dln@arity.se";
  };

  programs.jujutsu = {
    settings = {
      user = {
        email = config.programs.git.settings.user.email;
        name = config.programs.git.settings.user.name;
      };

      git = {
        sign-on-push = true;
      };

      signing = {
        behavior = "drop";
        backend = "ssh";
        backends.ssh.allowed-signers = "/home/dln/.ssh/authorized_keys";
        key = "/home/dln/.ssh/git_signing_key.pub";
      };

      gerrit = {
        default-remote = "origin";
        default-remote-branch = "main";
      };

      templates.git_push_bookmark = "'dln/push-' ++ change_id.short()";

      templates.log_short = ''
        if(root,
          format_root_commit(self),
          label(if(current_working_copy, "working_copy"),
            concat(
              separate(" ",
                format_short_change_id_with_hidden_and_divergent_info(self),
                if(empty, label("empty", "(empty)")),
                if(description,
                  description.first_line(),
                  label(if(empty, "empty"), description_placeholder),
                ),
                bookmarks,
                tags,
                working_copies,
                if(git_head, label("git_head", "HEAD")),
                if(conflict, label("conflict", "conflict")),
                if(config("ui.show-cryptographic-signatures").as_boolean(),
                  format_short_cryptographic_signature(signature)),
              ) ++ "\n",
            ),
          )
        )
      '';

      ui = {
        "default-command" = [ "s" ];
        pager = "delta";
      };

      "merge-tools" = {
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
          "--limit=15"
          "-T"
          "builtin_log_comfortable"
          "-r"
          "(main..@) | (main..@)-"
        ];
        la = [
          "log"
          "-T"
          "builtin_log_oneline"
          "-r"
          "all()"
          "--limit=15"
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
        evolve = [
          "rebase"
          "--skip-emptied"
          "--destination"
          "trunk()"

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
              jj log -T builtin_log_comfortable -r '(main..@) | (main..@)-'
            fi
          ''
          ""
        ];
        sync = [
          "git"
          "fetch"
          "--all-remotes"
        ];
        tug = [
          "util"
          "exec"
          "--"
          "bash"
          "-c"
          ''
            #!/usr/bin/env bash
            set -eu pipefail
            jj sync && jj evolve && jj
          ''
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

}
