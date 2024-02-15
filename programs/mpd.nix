{config, ...}: {
  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    playlistDirectory = "${config.home.homeDirectory}/Music/Playlists";
    dataDir = "${config.xdg.dataHome}/mpd";
    extraConfig = ''
      audio_output {
        type "alsa"
        name "My ALSA"
      }
    '';
  };
}
