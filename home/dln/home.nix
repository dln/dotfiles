{ config, pkgs, ... }:
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
      openconnect
      ouch
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
    # extraPackages = [];
  };

  programs.jujutsu = {
    settings = {
      user = {
        email = email;
        name = realName;
      };

      signing = {
        sign-all = true;
        backend = "ssh";
        backends.ssh.allowed-signers = "/home/dln/.ssh/authorized_keys";
        key = "/home/dln/.ssh/git_signing_key.pub";
      };

      git = {
        push-bookmark-prefix = "dln/push-";
      };

      ui = {
        "default-command" = [
          "log"
          "--limit=10"
          "-T"
          "builtin_log_comfortable"
        ];
        pager = "delta";
      };

      "merge-tools" = {
        difft."diff-args" = [
          "--color=always"
          "--missing-as-empty"
          "$left"
          "$right"
        ];
        difftu = {
          program = "difft";
          "diff-args" = [
            "--color=always"
            "--display=inline"
            "--missing-as-empty"
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
          "--tool=difftu"
        ];
        dd = [
          "diff"
          "--git"
        ];
        ds = [
          "diff"
          "--tool=difft"
        ];
        s = [
          "show"
          "--tool=difftu"
        ];
        ss = [
          "show"
          "--tool=difft"
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

      colors = {
        "commit_id prefix" = {
          bold = true;
        };

        "rest" = {
          fg = "bright black";
          bold = false;
        };

        "diff added token" = {
          bg = "#002200";
          fg = "#66ffcc";
          underline = false;
        };
        "diff removed token" = {
          bg = "#220011";
          underline = true;
        };
      };
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
      ];
    };
  };

  services.syncthing.enable = true;

  home.stateVersion = "24.05"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
}
