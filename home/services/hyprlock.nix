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
      disable_loading_bar = false;
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

    input-fields = [
      {
        size.width = 300;
        size.height = 40;
        outline_thickness = 3;
        dots_center = true;
        outer_color = withHashtag.base00;
        inner_color = withHashtag.base05;
        font_color = withHashtag.base00;
        fade_on_empty = false;
        dots_spacing = 0.3;
        placeholder_text = "";
        hide_input = false;
        position = {
          x = 0;
          y = -50;
        };
        halign = "center";
        valign = "center";
      }
    ];

    labels = [
      {
        text = ''cmd[update:100] echo "<b>$(date +'%_I:%M:%S')</b>"'';
        position = {
          x = 0;
          y = 30;
        };
        font_family = "${config.stylix.fonts.monospace.name}";
        font_size = 40;
        color = withHashtag.base07;
      }
    ];
  };
}
