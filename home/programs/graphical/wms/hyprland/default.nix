{
  osConfig,
  lib,
  ...
}: let
  inherit (builtins) filter map toString;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.modules) mkIf;
  inherit (lib.strings) hasSuffix;
in {
  imports = filter (hasSuffix ".nix") (
    map toString (filter (path: path != ./default.nix) (listFilesRecursive ./config))
  );
  config = mkIf osConfig.programs.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      systemd = {
        enable = true;
        variables = ["--all"];
      };
    };
  };
}
