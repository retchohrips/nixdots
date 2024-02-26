{
  pkgs,
  config,
  ...
}: let
  theme = with config.lib.stylix.colors; ''
    # --> Catppuccin (Dynamic)
    thm_bg=\"${withHashtag.base00}\"
    thm_fg=\"${withHashtag.base05}\"
    thm_cyan=\"${withHashtag.base0C}\"
    thm_black=\"${withHashtag.base01}\"
    thm_gray=\"${withHashtag.base02}\"
    thm_magenta=\"${withHashtag.base0E}\"
    thm_pink=\"${withHashtag.base0F}\"
    thm_red=\"${withHashtag.base08}\"
    thm_green=\"${withHashtag.base0B}\"
    thm_yellow=\"${withHashtag.base0A}\"
    thm_blue=\"${withHashtag.base0D}\"
    thm_orange=\"${withHashtag.base09}\"
    thm_black4=\"${withHashtag.base00}\"
  '';
  catppuccin-tmux = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "catppuccin";
    version = "20240118";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "main";
      sha256 = "sha256-78TRFzWUKLR4QuZeiXTa4SzWHxprWav93G21uUKzBfA=";
    };
    postInstall = ''
      echo "${theme}" > $target/catppuccin-dynamic.tmuxtheme
    '';
  };
in {
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      yank
      {
        plugin = catppuccin-tmux;
        extraConfig = with config.lib.stylix.colors; ''
          set -g @catppuccin_flavour "dynamic"
          set -g @catppuccin_window_left_separator "█"
          set -g @catppuccin_window_right_separator "█ "
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_middle_separator "  █"

          set -g @catppuccin_window_default_fill "number"

          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#{pane_current_path}"

          set -g @catppuccin_status_modules_right "application"
          set -g @catppuccin_status_left_separator  ""
          set -g @catppuccin_status_right_separator " "
          set -g @catppuccin_status_right_separator_inverse "yes"
          set -g @catppuccin_status_fill "all"
          set -g @catppuccin_status_connect_separator "no"
        '';
      }
    ];
    prefix = "C-Space";
    mouse = true;
    keyMode = "vi";
    extraConfig = ''
      # Start Windows and panes at 1, not 0
      set -g base-index 1
      set -g pane-base-index 1
      set-window-option -g pane-base-index 1
      set-option -g renumber-windows on # renumber all windows when any window is closed

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
      set -g status-position top # Move bar to top
    '';
  };
  programs.fish = {
    interactiveShellInit =
      /*
      fish
      */
      ''
        if status is-interactive
        and not set -q TMUX
        and command -v tmux &> /dev/null
          exec tmux new-session -A -s main
        end'';
  };
}
