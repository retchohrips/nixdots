{
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
}
