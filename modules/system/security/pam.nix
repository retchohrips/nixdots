{config, ...}: {
  security.pam.services = let
    gnupg = {
      enable = true;
      noAutostart = true;
      storeOnly = true;
    };
  in {
    hyprlock.text = "auth include login";
    greetd = {
      enableGnomeKeyring = config.services.gnome.gnome-keyring.enable && config.services.greetd.enable;
      inherit gnupg;
    };
  };
}
