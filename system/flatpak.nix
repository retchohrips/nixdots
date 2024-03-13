{
  config,
  pkgs,
  ...
}: let
  mkRoSymBind = path: {
    device = path;
    fsType = "fuse.bindfs";
    options = ["ro" "resolve-symlinks" "x-gvfs-hide"];
  };
in {
  services.flatpak = {
    enable = true;
    update.onActivation = true;
    remotes = [
      {
        name = "flathub";
        location = "https://flathub.org/repo/flathub.flatpakrepo";
      }
      {
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }
    ];
    packages = [
      "com.valvesoftware.Steam"
      "io.github.Foldex.AdwSteamGtk"
      "com.github.tchx84.Flatseal"
      "com.vysp3r.ProtonPlus"
      "org.upscayl.Upscayl"
    ];
  };
  system.fsPackages = [pkgs.bindfs];
  fileSystems."/usr/share/icons" = mkRoSymBind (config.system.path + "/share/icons");

  xdg.portal = {
    enable = true;
    # xdgOpenUsePortal = true; # This breaks xdg-open???
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
}
