{
  inputs,
  config,
  lib,
  osConfig,
  ...
}:
with config.lib.stylix.colors; {
  imports = [
    inputs.hyprlock.homeManagerModules.default
  ];

  programs.hyprlock = lib.mkIf osConfig.programs.hyprland.enable {
    enable = true;
    general = {
      disable_loading_bar = true;
      hide_cursor = true;
    };

    backgrounds = [
      {
        path = "screenshot";
        blur_passes = 4;
        blur_size = 4;
        contrast = 1.2;
        brightness = 1.0;
        vibrancy = 1.0;
        noise = 2.0e-2;
      }
    ];
    labels = [
      {
        # Time
        text = ''cmd[update:30000] echo "$(date +"%_I:%M %P")"'';
        position = {
          x = -30;
          y = 0;
        };
        halign = "right";
        valign = "top";
        font_family = "${config.stylix.fonts.monospace.name}";
        font_size = 90;
        color = withHashtag.base05;
      }
      {
        # Date
        text = ''cmd[update:43200000] echo "$(date +"%A, %d %B %Y")"'';
        position = {
          x = -30;
          y = -150;
        };
        halign = "right";
        valign = "top";
        font_family = "${config.stylix.fonts.monospace.name}";
        font_size = 25;
        color = withHashtag.base05;
      }
    ];

    input-fields = [
      {
        size.width = 300;
        size.height = 60;
        outline_thickness = 4;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = withHashtag.base0E;
        inner_color = withHashtag.base02;
        font_color = withHashtag.base05;
        fade_on_empty = false;
        placeholder_text = "";
        hide_input = false;
        check_color = withHashtag.base0E;
        fail_color = withHashtag.base08;
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
        capslock_color = withHashtag.base0A;
        position = {
          x = 0;
          y = -35;
        };
        halign = "center";
        valign = "center";
      }
    ];
  };
}
