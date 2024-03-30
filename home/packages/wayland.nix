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

      (pkgs.writeShellApplication {
        name = "ocr";
        runtimeInputs = with pkgs; [tesseract grim slurp];
        text =
          /*
          bash
          */
          ''
            set -x

            echo "Generating a random ID..."
            id=$(tr -dc 'a-zA-Z0-9' </dev/urandom | fold -w 6 | head -n 1 || true)
            echo "Image ID: $id"

            echo "Taking screenshot..."
            grim -g "$(slurp -w 0 -b eebebed2)" /tmp/ocr-"$id".png

            echo "Running OCR..."
            tesseract /tmp/ocr-"$id".png - | wl-copy
            echo -en "File saved to /tmp/ocr-'$id'.png\n"


            echo "Sending notification..."
            notify-send "OCR " "Text copied!"

            echo "Cleaning up..."
            rm /tmp/ocr-"$id".png -vf

          '';
      })
    ];
  };
}
