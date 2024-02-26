{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    settings = {
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
}
