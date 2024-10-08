{ lib, pkgs, ... }:
{

  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "transient";
        src = pkgs.fishPlugins.transient-fish.src;
      }
    ];

    functions = {
      tmux-refresh-env = {
        description = "Refresh environment variables from tmux session";
        body = ''
          for var in (tmux show-environment | string match -rv '^-')
            set -l parts (string split -m 1 '=' $var)
            if test (count $parts) -eq 2
              set -Ux $parts[1] $parts[2]
            end
          end
        '';
      };

      kubectl = {
        description = "Wraps kubectl in grc";
        wraps = "kubectl";
        body = "grc.wrap kubectl $argv";
      };

      edit = {
        description = "Open a file in already running nvim and switch tab";
        argumentNames = [ "file" ];
        body = ''
          set _file (readlink -f "$file")
          if test -z "$file"
              set _root (vcs_root)
              set _file (fd --type f . "$_root" | sed -e "s#^$_root/##" | fzf --no-sort --layout=reverse)
              set _file "$_root/$_file"
          end
          set _nvim_socket "$XDG_RUNTIME_DIR/nvim-persistent.sock"
          if test -S "$_nvim_socket" && tmux select-window -t nvim 2>/dev/null
            nvim --server "$_nvim_socket" --remote "$_file"
            return 0
          end
          tmux new-window -S -n nvim nvim --listen "$_nvim_socket" "$_file"
        '';
      };

      jl.body = ''
        jj log --color=always --no-graph -T builtin_log_oneline -r 'all()' | fzf --ansi --reverse --wrap --preview 'jj show --tool=difftu {1}' --preview-window=down,70% --color=light
      '';

      __zoxide_zi_repaint.body = ''
        __zoxide_zi
        commandline -f repaint
      '';

      fish_jj_prompt.body = ''
        # Is jj installed?
        if not command -sq jj
            return 1
        end

        # Are we in a jj repo?
        if not jj root --quiet &>/dev/null
            return 1
        end

        # Generate prompt
        jj log --ignore-working-copy --no-graph --color always -r @ -T '
                separate(
                    " ",
                    change_id.shortest(),
                    coalesce(
                        surround(
                            "\"",
                            "\"",
                            if(
                                description.first_line().substr(0, 24).starts_with(description.first_line()),
                                description.first_line().substr(0, 24),
                                description.first_line().substr(0, 23) ++ "…"
                            )
                        ),
                        "(no description set)"
                    ),
                    branches.join(", "),
                    commit_id.shortest(),
                    if(conflict, "(conflict)"),
                    if(empty, "(empty)"),
                    if(divergent, "(divergent)"),
                    if(hidden, "(hidden)"),
                )
        '
      '';

      fish_prompt.body = ''
        echo
        string join "" -- (set_color --italics) (prompt_hostname) ':' (prompt_pwd --full-length-dirs=4) (set_color yellow) ' ❯ ' (set_color normal)
      '';

      fish_right_prompt.body = ''
        fish_jj_prompt || fish_vcs_prompt
      '';

      transient_prompt_func.body = ''
        echo
        string join "" -- (set_color yellow) '❯ ' (set_color normal)
      '';

      rg.body = ''
        if status is-interactive
          command rg -p $argv --json | delta
        else
          command rg $argv
        end
      '';
    };

    interactiveShellInit = lib.concatStringsSep "\n" [
      (builtins.readFile ../../files/config/fish/config.fish)
      (builtins.readFile ../../files/config/fish/semantic-prompt.fish)
      (builtins.readFile ../../files/config/fish/go-task.fish)
      (builtins.readFile ../../files/config/fish/jj.fish)
      (builtins.readFile ../../files/config/fish/vcs.fish)
    ];

    shellAbbrs = {
      e = "edit";
      l = "bat";
      ls = "eza";
      tree = "eza --tree";
      top = "btm --basic --enable_cache_memory --battery";
      ts = "TZ=Z date '+%Y%m%dT%H%M%SZ'";
      w = "viddy -n1 $history[1]";
      xc = "fish_clipboard_copy";
    };
  };
}
