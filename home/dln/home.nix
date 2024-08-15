{ pkgs, ... }:
let
  realName = "Daniel Lundin";
  email = "dln@arity.se";
in
{
  home = {
    username = "dln";
    homeDirectory = "/home/dln";
    packages = with pkgs; [
      openconnect
      ouch
    ];
  };

  programs.atuin.settings = {
    cwd_filter = [
      "^~/media"
      "^/home/dln/media"
    ];
  };

  programs.git = {
    userName = realName;
    userEmail = email;
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

      ui = {
        "default-command" = [
          "log"
          "--limit=25"
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
        b = [
          "branch"
          "list"
        ];
        n = [
          "new"
          "main"
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
        "immutable_heads()" = "main@origin | (main@origin.. & ~mine())";
        "user(x)" = "author(x) | committer(x)";
        "trunk()" = "latest((present(main) | present(master)) & remote_branches())";
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
      };
    };
  };

  programs.ssh.matchBlocks = {
    dev = {
      hostname = "10.1.100.16";
      forwardAgent = true;
    };

    nemo = {
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
