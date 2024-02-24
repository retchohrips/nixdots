{pkgs, ...}: {
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages =
    (with pkgs; [gnome-tour gnome-console])
    ++ (with pkgs.gnome; [
      gnome-calendar
      geary # mail
      cheese # Webcam tool
      gnome-terminal
      epiphany # Web browser
      yelp # Help viewer
      gnome-maps
    ]);
}
