{
  config,
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [
    delta
    diffedit3
    difftastic
    git-get
    git-graph
    mergiraf
    tea
  ];

  programs.git = {
    enable = true;

    aliases = {
      b = "branch -va";
      cl = "clone --filter=blob:none";
      co = "checkout";
      d = "diff --stat -p -C --color-words";
      ds = "diff --staged --stat -p -C --color-words";
      g = "graph -S -m simple -s round";
      guilt = "!f(){ git log --pretty='format:%an <%ae>' $@ | sort | uniq -c | sort -rn; }; f";
      lla = "log --graph --all --topo-order --pretty='format:\t%x1B[0;3;36m%as %x1B[0;95;3m%<(12)%al %x1B[3;32m• %h%x1B[0;1;92m%d%x1B[0m %s'";
      ll = "log --pretty='format:%x1B[0;3;36m%as %G? %x1B[0;95;3m%<(12,trunc)%al %x1B[3;32m• %h%x1B[0;1;92m%(decorate:prefix= [,suffix=]%n)%>|(35)%Creset %s'";
      patch = "!git --no-pager diff --no-color";
      pullr = "pull --rebase --autostash";
      sh = "show --stat -p -C --color-words --show-signature";
      st = "status -sb";
    };

    delta = {
      enable = true;
      options = {
        file-added-label = "[+]";
        file-decoration-style = "none";
        file-modified-label = "[*]";
        file-removed-label = "[-]";
        file-renamed-label = "[>]";
        file-style = "bold reverse";
        file-transformation = "s/$/  ░▒▓/";
        grep-file-style = "bold reverse";
        hunk-header-decoration-style = "none";
        hunk-header-file-style = "bold";
        hunk-header-line-number-style = "bold";
        hunk-header-style = "bold";
        hunk-label = "⯁";
        hunk-label-style = "bold";
        line-numbers = true;
        max-line-distance = "0.9";
        navigate = true;
      };
    };

    extraConfig = {
      apply.whitespace = "nowarn";
      blame.date = "relative";
      branch.main.rebase = true;
      color = {
        branch = "auto";
        diff = "auto";
        status = "auto";
        ui = "auto";
      };
      column.ui = "auto";
      core = {
        compression = 3;
        looseCompression = 3;
        excludesfile = "~/.config/git/ignore";
      };
      fetch = {
        prune = true;
        prunetags = true;
        showForcedUpdates = true;
      };
      gitget = {
        root = "${config.home.homeDirectory}/src/oss";
      };
      gpg = {
        format = "ssh";
        ssh = {
          allowedSignersFile = "${config.home.homeDirectory}/.ssh/authorized_keys";
          defaultKeyCommand = "${config.home.homeDirectory}/.local/bin/git-signing-key";
        };
      };
      init.defaultBranch = "main";
      merge.conflictstyle = "zdiff3";
      pack = {
        compression = 3;
        threads = 0;
      };
      pull.rebase = true;
      push.default = "tracking";
      rebase.autosquash = true;
      rerere.enabled = true;
      tag.sort = "-v:refname";
      user.useConfigOnly = true;
    };

    ignores = [
      "*~"
      "*.a"
      "*.class"
      "*.iml"
      "*.ipr"
      "*.iwr"
      "*.iws"
      "*.la"
      "*.o"
      "*.pyc"
      "*.so"
      "*.swp"
      ".direnv"
      ".env"
      ".idea"
      ".nixos-test-history"
      ".null-ls_*"
      "/result*"
      "/target"
    ];

    signing = {
      key = null;
      signByDefault = true;
    };
  };

  programs.jujutsu = {
    enable = true;
  };
}
