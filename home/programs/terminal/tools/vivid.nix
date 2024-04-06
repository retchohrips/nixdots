{config, ...}: {
  programs.vivid = {
    enable = true;
    enableFishIntegration = true;
    theme = "stylix";
    themes = {
      stylix = {
        colors = with config.lib.stylix.colors; {
          base00 = "${base00}";
          base01 = "${base01}";
          base02 = "${base02}";
          base03 = "${base03}";
          base04 = "${base04}";
          base05 = "${base05}";
          base06 = "${base06}";
          base07 = "${base07}";
          base08 = "${base08}";
          base09 = "${base09}";
          base0A = "${base0A}";
          base0B = "${base0B}";
          base0C = "${base0C}";
          base0D = "${base0D}";
          base0E = "${base0E}";
          base0F = "${base0F}";
        };

        core = {
          normal_text = {};
          regular_file = {};
          reset_to_normal = {};

          directory.foreground = "base0D";
          symlink.foreground = "base0F";
          multi_hard_link = {};

          fifo = {
            foreground = "base01";
            background = "base0D";
          };

          socket = {
            foreground = "base01";
            background = "base0F";
          };

          door = {
            foreground = "base01";
            background = "base0F";
          };

          block_device = {
            foreground = "base0C";
            background = "base02";
          };

          character_device = {
            foreground = "base0F";
            background = "base02";
          };

          broken_symlink = {
            foreground = "base01";
            background = "base08";
          };

          missing_symlink_target = {
            foreground = "base01";
            background = "base08";
          };

          setuid = {};
          setgid = {};
          file_with_capability = {};
          sticky_other_writable = {};
          other_writable = {};
          sticky = {};

          executable_file = {
            foreground = "base08";
            font-style = "bold";
          };
        };

        text = {
          special = {
            foreground = "base00";
            background = "base0A";
          };

          todo.font-style = "bold";

          licenses.foreground = "base04";
          configuration.foreground = "base0A";
          other.foreground = "base0A";
        };

        markup.foreground = "base0A";

        programming = {
          source.foreground = "base0B";
          tooling = {
            foreground = "base0C";
            continuous-integration.foreground = "base0B";
          };
        };

        media.foreground = "base0F";
        office.foreground = "base08";

        archives = {
          foreground = "base0C";
          font-style = "underline";
        };

        executable = {
          foreground = "base08";
          font-style = "bold";
        };

        unimportant.foreground = "base04";
      };
    };
  };
}
