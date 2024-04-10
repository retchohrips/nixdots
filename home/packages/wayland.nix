{
  osConfig,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.programs.hyprland.enable {
    home.packages = with pkgs; [
      wl-clipboard
      cliphist
      loupe
      gnome.nautilus
      gnome.sushi # File previewer for Nautilus
      gnome.seahorse
      gnome.totem
      gnome-text-editor
      gnome.gnome-calculator
      xarchiver
      grimblast
      brightnessctl
      hyprpaper
      wlsunset
      hyprpicker
      wf-recorder
      wlogout

      (pkgs.writeShellApplication {
        name = "wlsunset-auto";
        runtimeInputs = with pkgs; [curl jq wlsunset];
        text =
          /*
          bash
          */
          ''
            curl https://ipinfo.io/json | jq -r '.loc' | awk -F, '{print "-l " $1 " -L " $2}' | xargs wlsunset
          '';
      })
    ];
  };
}
