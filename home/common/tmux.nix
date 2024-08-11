{ ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 10;
    mouse = true;
    shortcut = "o";
    extraConfig = ''
      set -g allow-passthrough on
      set -g display-panes-time 3000
      set -g history-limit 10000
      set -g status off
      setw -g alternate-screen on
      setw -g automatic-rename off
      bind -n M-1 select-window -t 42
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9
      bind -n M-0 select-window -t 10
      bind -T copy-mode-vi WheelUpPane select-pane \; send-keys -X -N 1 scroll-up
      bind -T copy-mode-vi WheelDownPane select-pane \; send-keys -X -N 1 scroll-down
      bind C-s set-option -g status
      bind K confirm kill-server
      new -s0 -n 1
      new-window -n 2
      new-window -n 3
      new-window -n 4
      new-window -n 5
      new-window -n 6
      new-window -n 7
      new-window -n 8
      new-window -n 9
      new-window -n 0
    '';
  };
}
