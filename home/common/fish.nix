{ lib, pkgs, ... }:
{
  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "transient";
        src = pkgs.fishPlugins.transient-fish.src;
      }
    ];

    functions = {
      confirm = {
        description = "Ask for confirmation";
        argumentNames = [ "message" ];
        body = ''
          read -l -p 'printf "\\e[31;1m$message\\e[0m (y/N) "' confirm
          test "$confirm" = 'y'
        '';
      };

      poweroff = {
        description = "Wraps poweroff to first prompt for confirmation";
        wraps = "poweroff";
        body = ''confirm "⚠ Really poweroff $(hostname)?" && command poweroff $argv'';
      };

      reboot = {
        description = "Wraps reboot to first prompt for confirmation";
        wraps = "reboot";
        body = ''confirm "⚠ Really reboot $(hostname)?" && command reboot $argv'';
      };

      shutdown = {
        description = "Wraps shutdown to first prompt for confirmation";
        wraps = "shutdown";
        body = ''confirm "⚠ Really shutdown $(hostname)?" && command shutdown $argv'';
      };

      e = {
        description = "Open a file in already running nvim";
        argumentNames = [ "file" ];
        body = ''
          nvim-remote --remote (readlink -f "$file")
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
          if not command -sq jj || not jj root --quiet &>/dev/null
            return 1
          end

        jj log --ignore-working-copy --no-graph --color never -r @ -T '
          surround(
            " \e[2;3m",
            "\e[0m",
            separate(
              " ",
              surround(
                "\e[0;2;3m",
                "\e[0m",
                coalesce(
                  surround(
                    "\e[1;2;3m❝",
                    "❞\e[0m",
                    if(
                      description.first_line().substr(0, 80).starts_with(description.first_line()),
                      description.first_line().substr(0, 80),
                      description.first_line().substr(0, 79) ++ "…"
                    )
                  ),
                  "…"
                ),
              ),
              surround("\e[0;1;95m ", "\e[0;2;3m", change_id.shortest()),
              surround("\e[0;35m󰸕 ", "\e[0m", bookmarks.join("╱")),
              surround("\e[0;34m ",   "\e[0;2;3m", commit_id.shortest()),
              if(conflict,  "󰂭"),
              if(empty,     ""),
              if(divergent, ""),
              if(hidden,    "󰘓"),
            )
          )
        '
      '';

      fish_prompt.body = ''
        echo -e "\033[s\033[$LINES;1H\033[1;2;38;5;238m$(string pad -c '┄' -w $COLUMNS (fish_jj_prompt || fish_vcs_prompt))\033[0m\033[u"
        string join "" -- (set_color --dim) (prompt_hostname) ':' (prompt_pwd --full-length-dirs=4) (set_color --bold normal) ' ❯ ' (set_color normal)
      '';

      transient_prompt_func.body = ''
        echo
        string join "" -- (set_color --bold) '❯ ' (set_color normal)
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
      (builtins.readFile ../../files/config/fish/vcs.fish)
    ];

    shellAbbrs = {
      l = "bat";
      top = "btm --basic --enable_cache_memory --battery";
      ts = "TZ=Z date '+%Y%m%dT%H%M%SZ'";
      w = "viddy $history[1]";
      xc = "fish_clipboard_copy";
    };
  };
}
