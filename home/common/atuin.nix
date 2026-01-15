{ lib, pkgs, ... }:
{
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    daemon.enable = true;
    settings = {
      ctrl_n_shortcuts = true;
      enter_accept = true;
      filter_mode_shell_up_key_binding = "session";
      inline_height = 8;
      prefers_reduced_motion = true;
      search_mode_shell_up_key_binding = "prefix";
      show_help = false;
      show_tabs = false;
      style = "compact";
      sync_address = "https://atuin.patagia.net";
      sync.records = true;

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

      stats.common_subcommands = [
        "cargo"
        "git"
        "go"
        "jj"
        "just"
        "kubectl"
        "nix"
        "npm"
        "pnpm"
        "talosctl"
        "task"
        "yarn"
      ];

      stats.common_prefix = [
        "doas"
        "run0"
        "sudo"
      ];
    };
  };
}
