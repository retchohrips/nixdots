{pkgs, ...}: {
  imports = [../mpdscribble.nix];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [polkit_gnome];

  security = {
    pam.services = {
      hyprlock.text = "auth include login";
      greetd.enableGnomeKeyring = true;
    };

    polkit.enable = true;
  };

  services = {
    gnome.gnome-keyring.enable = true;
    dbus.packages = [pkgs.gcr]; # GNOME services outside of GNOME
  };
}
