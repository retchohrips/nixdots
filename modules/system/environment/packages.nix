{
  pkgs,
  lib,
  config,
  ...
}: {
  # Packages that should always be installed
  environment.systemPackages = with pkgs;
    [
      git
      curl
      wget
      lshw
      rsync
      man-pages
    ]
    ++ lib.optionals config.programs.hyprland.enable [wineWowPackages.waylandFull];
}
