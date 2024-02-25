{
  userSettings,
  pkgs,
  inputs,
  ...
}: {
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    shellIntegration.enableFishIntegration = true;
    settings = {
      font = "${userSettings.font}";
      font_size = 12;
      cursor_shape = "beam";
      window_padding_width = 5;
      confirm_os_window_close = 0;
      linux_display_server = "x11";
      # background_opacity = "0.50";
      enabled_layouts = "grid, splits, tall, fat";
    };
  };

  programs.git.extraConfig = {
    diff.tool = "kitty";
    diff.guitool = "kitty.gui";
    difftool.prompt = false;
    difftool.trustExitCode = true;
    "difftool \"kitty\"".cmd = "${pkgs.kitty}/bin/kitty +kitten diff $LOCAL $REMOTE";
    "difftool \"kitty.gui\"".cmd = "${pkgs.kitty}/bin/kitty kitty +kitten diff $LOCAL $REMOTE";
  };

  xdg.configFile = {
    "kitty/diff.conf".text = ''
      # Load theme
      include ${inputs.catppuccin-kitty}/themes/diff-mocha.conf
    '';
  };
}