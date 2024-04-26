{
  pkgs,
  lib,
  osConfig,
  ...
}: let
  acceptedTypes = ["desktop" "laptop"];
in {
  config = lib.mkIf (builtins.elem osConfig.modules.device.type acceptedTypes) {
    home.packages = with pkgs; [
      (discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
    ];
    xdg.configFile.openASAR-settings = {
      target = "discord/settings.json";
      text = builtins.toJSON {
        openasar = {
          setup = true;
          quickstart = true;
          noTyping = false;
          cmdPreset = "balanced";
          css = ''
            @import url("https://catppuccin.github.io/discord/dist/catppuccin-frappe-mauve.theme.css");
          '';
        };
        SKIP_HOST_UPDATE = true;
        IS_MAXIMIZED = true;
        IS_MINIMIZED = false;
        trayBalloonShown = true;
      };
    };
  };
}
