{
  pkgs,
  config,
  ...
}: let
  inherit (config.colorscheme) palette;
in {
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.catppuccin
      tmuxPlugins.yank
    ];
    prefix = "C-Space";
    mouse = true;
    keyMode = "vi";
    extraConfig = ''
      # Start Windows and panes at 1, not 0
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on

      bind -n M-H previous-window
      bind -n M-L next-window

      # Vi-like copying
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Open panes in current directory
      bind % split-window -v -c "#{pane_current_path}"
      bind '"' split-window -h -c "#{pane_current_path}"

      # Status line
      # Make background transparent
      set -g status-bg default
      set -g status-style bg=default

      # pane borders
      # set -g pane-border-style "fg=colour1"
      # set -g pane-active-border-style "fg=colour3"
    '';
  };
}
